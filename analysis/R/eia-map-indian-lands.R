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
source("00-pd-themes.R")

# Map of Indian Lands ---------------------------------------------------------

# READ IN SHAPEFILE
native <-  readOGR(dsn = "/Users/pdpd/GitHub/standing-rock-research/data/EIA/indlanp010g.shp_nt00968",
                   layer = "indlanp010g")

summary(native)

# create dataframe
native.map <- fortify(native)
str(native.map)
summary(native.map)

native.map$id <- factor(native.map$id)
levels(native.map$id)

# map urban population percentage by county
ggplot(native.map, aes(long, lat, 
                  group = group)) +
  geom_polygon(color = "white", size = 0.025) +
  coord_map("polyconic") + 
  pd.theme +
  theme(legend.position = "right",
        panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text = element_blank()) +
  guides(fill = guide_legend(reverse = T)) +
  labs(title = "", 
       x = "", y = "", fill = "")

