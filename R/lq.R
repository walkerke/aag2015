# Script to create maps and charts examining lq shifts in Chi and DFW
# 
# Steps: 
#   
# 1. Format the data
# 2. Prepare the loess plots
# 3. Export for mapping (to be done in ArcGIS w/template from October)

library(ggplot2)

source('R/data_prep.R')

source('R/functions.R')

# Chicago

chicago <- metro %>%
  filter(metroid == 16980) %>%
  mutate(
    lq_latam_2013 = lq(latam_2013, total_2013), 
    lq_ese_2013 = lq(eseasia_2013, total_2013), 
    lq_latam_2000 = lq(latam_2000, total_2000), 
    lq_ese_2000 = lq(eseasia_2000, total_2000)
  ) %>%
  mutate(
    lq_latam_diff = lq_latam_2013 - lq_latam_2000, 
    lq_ese_diff = lq_ese_2013 - lq_ese_2000, 
    dist_miles = distance / 1609.34
  )

ggplot(chicago, aes(x = dist_miles, y = lq_latam_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

ggplot(chicago, aes(x = dist_miles, y = lq_ese_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

# Loess for both years - lq

ggplot(chicago) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2000), method = "loess", color = "blue") + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2013), method = "loess", color = "red")

ggplot(chicago) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2000), method = "loess", color = "blue") + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2013), method = "loess", color = "red")

# Dallas

dallas <- metro %>%
  filter(metroid == 19100) %>%
  mutate(
    lq_latam_2013 = lq(latam_2013, total_2013), 
    lq_ese_2013 = lq(eseasia_2013, total_2013), 
    lq_latam_2000 = lq(latam_2000, total_2000), 
    lq_ese_2000 = lq(eseasia_2000, total_2000)
  ) %>%
  mutate(
    lq_latam_diff = lq_latam_2013 - lq_latam_2000, 
    lq_ese_diff = lq_ese_2013 - lq_ese_2000, 
    dist_miles = distance / 1609.34
  )


ggplot(dallas, aes(x = dist_miles, y = lq_latam_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

ggplot(dallas, aes(x = dist_miles, y = lq_ese_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

ggplot(dallas) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2000), method = "loess", color = "blue", se = FALSE) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2013), method = "loess", color = "red", se = FALSE) + 
  theme_minimal() + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 6, fontface = "bold") + 
  annotate("text", x = 51, y = 1.6, label = "2000", color = "blue", size = 6, fontface = "bold") 

ggplot(dallas) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2000), method = "loess", color = "blue", se = FALSE) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2013), method = "loess", color = "red", se = FALSE) + 
  theme_minimal() + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 6, fontface = "bold") + 
  annotate("text", x = 51, y = 1.6, label = "2000", color = "blue", size = 6, fontface = "bold") 

# For mapping

library(rgdal)

chi_tracts <- readOGR(dsn = "data/shape", layer = "chi_tracts")

dfw_tracts <- readOGR(dsn = "data/shape", layer = "dfw_tracts")

# ggplot(data = dfw_tracts) + geom_polygon(aes(x = long, y = lat, group = group)) + coord_equal(ratio = 1)



