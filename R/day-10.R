#Liam Finn
#August 18th, 2020
#Daily Activity #10

library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(sf)
USAboundaries:: us_states()
states = us_states()


#filter to Conterminous by removing PR, AK, and HI
conterminous= states %>%
  filter(!name %in% c("Puerto Rico", "Alaska", "Hawaii"))

usa_c=st_combine(conterminous)  %>%
  st_cast("MULTILINESTRING")
plot(usa_c)

usa_u = st_union(conterminous) %>%
  st_cast("MULTILINESTRING")
plot(usa_u)
