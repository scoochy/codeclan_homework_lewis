library(tidyverse)
library(tidyr)
library(here)
library(stringr)
library(assertr)

meteors <- read.csv("data/meteorite_landings.csv")

#read.csv changes mass(g) into mass..g. will verify this instead

meteors %>% 
  verify(colnames(meteors) %in% c("id", "name", "mass..g.", "fall", "year", "GeoLocation"))

meteors_clean <- meteors %>% 
  separate(col = GeoLocation,
           into = c("latitude", "longitude"),
           sep = ",") %>% 
  mutate(latitude = as.numeric(str_remove(latitude, "\\(")),
         longitude = as.numeric(str_remove(longitude, "\\)"))) %>% 
  mutate(latitude = coalesce(latitude, 0),
         longitude = coalesce(longitude, 0)) %>% 
  filter(mass..g. > 1000) %>% 
  #had trouble filtering mass(g) so had to rename as the last operation
  rename("mass(g)" = mass..g.) %>% 
  arrange(year)

meteors_clean %>% 
  verify(latitude >= -90 & latitude <= 90) %>% 
  verify(longitude >= -180 & longitude <= 180) 
    
