# Standing Rock Research
# EIA - Indian Lands
# https://nationalmap.gov/small_scale/atlasftp.html?openChapters=chpbound#chpbound

# load data -------------------------------------------------------------------

library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(mapproj)
library(rgdal)

# custom themes
source("~/GitHub/standing-rock-research/analysis/R/00-pd-themes.R")

# Prepare Map data ------------------------------------------------------------

# READ IN SHAPEFILES: Indian Lands
native <-  readOGR(dsn = "/Users/pdpd/GitHub/standing-rock-research/data/EIA/indlanp010g.shp_nt00968",
                   layer = "indlanp010g")

# READ IN SHAPEFILES: Federal Lands
federal <- readOGR(dsn = "/Users/pdpd/GitHub/standing-rock-research/data/EIA/fedlanp010g.shp_nt00966",
                   layer = "fedlanp010g")

# create dataframe: native lands
native.map <- fortify(native)
str(native.map)
summary(native.map)

native.map$id <- factor(native.map$id)
levels(native.map$id)

# subset out alaska+hawaii
native.map <- native.map %>%
  filter(long > -120)

# create dataframe: federal lands
fed.map <- fortify(federal)
summary(fed.map)

fed.map$id <- factor(fed.map$id)

# subset out alaska+hawaii
fed.map <- fed.map %>%
  filter(long > -120)


# Map of Indian Lands --------------------------------------------------------
ggplot(native.map, aes(long, lat, group = group)) +
  geom_polygon(color = "white", fill = "deepskyblue4", size = 0.025) +
  geom_polygon(data = fed.map,
               aes(long, lat, group = group),
               color = "white", fill = "antiquewhite2", size = 0.025) +
  coord_map("polyconic") + 
  pd.theme +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text = element_blank()) +
  guides(fill = guide_legend(reverse = T)) +
  labs(title = "", 
       x = "", y = "", fill = "")

