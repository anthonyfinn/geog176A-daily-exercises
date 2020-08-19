#Liam Finn
#August 18th, 2020

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014")
# Clean workspace
rm(list=ls())



install.packages(c("sf",
                    "stars",
                    "units",
                    "raster",
                    "mapview",
                    "leaflet",
                    "gdalUtilities"))
install.packages("whitebox", repos="http://R-Forge.R-project.org")

remotes::install_github(c("ropensci/getlandsat",
"ropensci/USAboundaries",
"ropensci/USAboundariesData",
"ropenscilabs/rnaturalearthdata"))

sf::sf_extSoftVersion()
