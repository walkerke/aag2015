## Script to prepare and merge the data from 2000 to 2013

# A little background: 
# Demographic and spatial data are from NHGIS, http://www.nhgis.org. 
# Census tract data from 2000 were adjusted to 2010 boundaries in Stata using the script available
#   from Brown U.'s LTDB project, http://www.s4.brown.edu/us2010/Researcher/LTDB.htm.  
# Distances from tract centroids to their corresponding city halls were calculated in ArcGIS using Python/ArcPy. 
#
# These scripts are stored external to the repository; please contact me if you'd like to access them.  

library(readr)
library(dplyr)
library(stringr)
library(haven)
library(magrittr)
library(tidyr)

immig <- read_csv('data/immigrants.csv')

# Subset the data to match the categories from 2000, using 2009-2013 ACS data

regions <- immig %>%
  rename(europe = UPVE002, oceania = UPVE116, latam = UPVE123, canada = UPVE159, 
         sasia = UPVE056, state = STATEA, county = COUNTYA, tract = TRACTA) %>%
  mutate(
    eseasia = UPVE048 + UPVE067, 
    swanaf = UPVE078 + UPVE100,  
    ssafr = UPVE092 + UPVE097 + UPVE105 + UPVE108, 
    tractid = paste0(str_pad(as.character(state), width = 2, side = "left", pad = "0"),  
                          str_pad(as.character(county), width = 3, side = "left", pad = "0"), 
                          str_pad(as.character(tract), width = 6, side = "left", pad = "0"))
     ) %>%
  select(tractid, europe, oceania, latam, canada, sasia, eseasia, swanaf, ssafr)

# Get total population

total13 <- read_csv('data/totalpop.csv') %>%
  select(state = STATEA, county = COUNTYA, tract = TRACTA, total = UEPE001) %>%
  mutate(tractid = paste0(str_pad(as.character(state), width = 2, side = "left", pad = "0"),  
                          str_pad(as.character(county), width = 3, side = "left", pad = "0"), 
                          str_pad(as.character(tract), width = 6, side = "left", pad = "0"))) %>%
  select(-state, -county, -tract)


regions13 <- left_join(regions, total13, by = "tractid")

colnames(regions13) <- paste0(colnames(regions13), "_2013")

regions13 %<>% rename(tractid = tractid_2013)


## Now, we pull in the 2000 data

regions00 <- read_stata('data/regions00to10.dta') 


## Need some way to distinguish columns - add "2000" to the names of vars

colnames(regions00) <- paste0(colnames(regions00), "_2000")

regions00 %<>% rename(tractid = trtid10_2000, total_2000 = total00_2000)

# Now, we need to bring in the distance dataset

dist <- read_csv('data/tract_distance.csv') %>%
  select(tractid = geoid10, distance = distance_f, metroid = geoid10_1) %>%
  mutate(tractid = str_pad(as.character(tractid), width = 11, side = "left", pad = "0"))

## First, we'll merge and then subset for metropolitan areas.  

metro <- regions13 %>%
  left_join(regions00, by = "tractid") %>%
  left_join(dist, by = "tractid") %>%
  filter(!is.na(distance))

metro[is.na(metro)] <- 0 



# We take this now into other scripts for visualization and analysis