# Script to create maps and charts examining lq shifts in Chi and DFW
# 
# Steps: 
#   
# 1. Format the data
# 2. Prepare the loess plots
# 3. Export for mapping in CartoDB (interactive) and ArcGIS (static) 

library(ggplot2)

source('R/data_prep.R')

source('R/functions.R')

# Check other loaded packages

sessionInfo()

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
    lq_ltm_rl = lq_latam_2013 / lq_latam_2000, 
    lq_ese_rl = lq_ese_2013 / lq_ese_2000,
    dist_miles = distance / 1609.34
  )

# ggplot(chicago, aes(x = dist_miles, y = lq_latam_diff)) + 
#   geom_point(alpha = 0.4) + 
#   stat_smooth(method = "loess") 
# 
# ggplot(chicago, aes(x = dist_miles, y = lq_ese_diff)) + 
#   geom_point(alpha = 0.4) + 
#   stat_smooth(method = "loess")

# Loess for both years - lq

ggplot(chicago) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2000), method = "loess", color = "blue", se = FALSE, size = 1.5) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2013), method = "loess", color = "red", se = FALSE, size = 1.5) + 
  theme_minimal(base_size = 18) + 
  geom_hline(yintercept = 1, linetype = "dashed", size = 1) + 
  annotate("text", x = 50, y = 1.05, label = "Same proportion as metropolitan area") + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 8, fontface = "bold") + 
  annotate("text", x = 50, y = 1.6, label = "2000", color = "blue", size = 8, fontface = "bold") + 
  xlab("Distance from city hall (miles)") + 
  ylab("Location quotient (loess)") + 
  xlim(0, 60) + 
  ggtitle("Latin American immigrants, Chicago")

ggsave("plots/c1.png", dpi = 300)

ggplot(chicago) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2000), method = "loess", color = "blue", se = FALSE, size = 1.5) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2013), method = "loess", color = "red", se = FALSE, size = 1.5) + 
  theme_minimal(base_size = 18) + 
  geom_hline(yintercept = 1, linetype = "dashed", size = 1) + 
  annotate("text", x = 50, y = 1.05, label = "Same proportion as metropolitan area") + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 8, fontface = "bold") + 
  annotate("text", x = 50, y = 1.6, label = "2000", color = "blue", size = 8, fontface = "bold") + 
  xlab("Distance from city hall (miles)") + 
  ylab("Location quotient (loess)") + 
  xlim(0, 60) + 
  ggtitle("East & SE Asian immigrants, Chicago")

ggsave("plots/c2.png", dpi = 300)

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
    lq_ltm_rl = lq_latam_2013 / lq_latam_2000, 
    lq_ese_rl = lq_ese_2013 / lq_ese_2000,
    dist_miles = distance / 1609.34
  )


ggplot(dallas, aes(x = dist_miles, y = lq_latam_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

ggplot(dallas, aes(x = dist_miles, y = lq_ese_diff)) + 
  geom_point(alpha = 0.4) + 
  stat_smooth(method = "loess")

ggplot(dallas) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2000), method = "loess", color = "blue", se = FALSE, size = 1.5) + 
  stat_smooth(aes(x = dist_miles, y = lq_latam_2013), method = "loess", color = "red", se = FALSE, size = 1.5) + 
  theme_minimal(base_size = 18) + 
  geom_hline(yintercept = 1, linetype = "dashed", size = 1) + 
  annotate("text", x = 50, y = 1.05, label = "Same proportion as metropolitan area") + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 8, fontface = "bold") + 
  annotate("text", x = 50, y = 1.6, label = "2000", color = "blue", size = 8, fontface = "bold") + 
  xlab("Distance from city hall (miles)") + 
  ylab("Location quotient (loess)") + 
  xlim(0, 60) + 
  ggtitle("Latin American immigrants, Dallas-Fort Worth")

ggsave("plots/d1.png", dpi = 300)

ggplot(dallas) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2000), method = "loess", color = "blue", se = FALSE, size = 1.5) + 
  stat_smooth(aes(x = dist_miles, y = lq_ese_2013), method = "loess", color = "red", se = FALSE, size = 1.5) + 
  theme_minimal(base_size = 18) + 
  geom_hline(yintercept = 1, linetype = "dashed", size = 1) + 
  annotate("text", x = 50, y = 1.05, label = "Same proportion as metropolitan area") + 
  annotate("text", x = 55, y = 1.6, label = "2013", color = "red", size = 8, fontface = "bold") + 
  annotate("text", x = 50, y = 1.6, label = "2000", color = "blue", size = 8, fontface = "bold") + 
  xlab("Distance from city hall (miles)") + 
  ylab("Location quotient (loess)") + 
  xlim(0, 60) + 
  ggtitle("East & SE Asian immigrants, Dallas-Fort Worth")

ggsave("plots/d2.png", dpi = 300)

# For mapping

library(rgdal)

chi_tracts <- readOGR(dsn = "data/shape", layer = "chi_tracts")

chi_tracts2 <- chi_tracts

chi_tracts2@data <- sp::merge(chi_tracts2@data, chicago, by = "tractid", sort = FALSE)

# Write for visualization in ArcGIS

writeOGR(chi_tracts2, dsn = "data/shape", layer = "chi_tracts2", 
         driver = "ESRI Shapefile", overwrite_layer = TRUE)

# Now, Dallas

dfw_tracts <- readOGR(dsn = "data/shape", layer = "dfw_tracts")

dfw_tracts2 <- dfw_tracts

dfw_tracts2@data <- sp::merge(dfw_tracts2@data, dallas, by = "tractid", sort = FALSE)

writeOGR(dfw_tracts2, dsn = "data/shape", layer = "dfw_tracts2", 
         driver = "ESRI Shapefile", overwrite_layer = TRUE)

# Push to CartoDB for interactive visualization
# Set WD to "data" first to save shapefile

library(kwgeo)

my_account_id = "kwalkertcu"

my_api_key = "not_for_sharing"

r2cartodb(chi_tracts2, "chicago1", my_account_id, my_api_key)

r2cartodb(dfw_tracts2, "dfw1", my_account_id, my_api_key)


#############################################################
# Old ggplot2/Leaflet mapping code; keep for future reference
#############################################################

# Try Leaflet

# library(leaflet)
# library(kwgeo)

# pal <- colorQuantile("RdBu", NULL, n = 7)
# 
# mb_tiles <- "http://a.tiles.mapbox.com/v3/kwalkertcu.l1fc0hab/{z}/{x}/{y}.png"
# 
# mb_attribution <- 'Mapbox <a href="http://mapbox.com/about/maps" target="_blank">Terms &amp; Feedback</a>'
# 
# leaflet(data = transform_xy(chi_tracts2)) %>%
#   addTiles(urlTemplate = mb_tiles, attribution = mb_attribution) %>%
#   addPolygons(fillColor = ~pal(lq_latam_diff), 
#               fillOpacity = 0.6, 
#               weight = 0.2)

# dfwtdf <- fortify(dfw_tracts, region = "tractid")
# 
# chitdf <- fortify(chi_tracts, region = "tractid")
# 
# chi2 <- chitdf %>%
#   left_join(chicago, by = c("id" = "tractid")) 
# 
# # Try plotting
# 
# ggplot(chi2) + 
#   geom_polygon(aes(x = long, y = lat, group = group, fill = lq_latam_diff)) + 
#   theme_minimal() + 
#   coord_equal() + 
#   scale_fill_gradient2(low = "blue", mid = "white", high = "red")


