# Chart 3 for Barplot

library(tidyverse)
library(ggplot2)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# What 10 fires had the maximum fire size during 2012-2015?
top_5_biggest_fire_size <- fire_2012_2015_df %>%
  top_n(5, wt = FIRE_SIZE) %>% 
  arrange(-FIRE_SIZE) %>%
  select(FIRE_NAME, FIRE_SIZE)

# Barplot
ggplot(top_5_biggest_fire_size, aes(x=FIRE_NAME, y=FIRE_SIZE)) + 
  geom_bar(stat = "identity")