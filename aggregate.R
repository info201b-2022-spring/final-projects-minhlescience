# Summary Information Script

library(tidyverse)
library(ggplot2)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# What 10 fires had the maximum fire size during 2012-2015?
top_10_biggest_fire_size <- fire_2012_2015_df %>%
  top_n(10, wt = FIRE_SIZE) %>% # a handy dplyr function!
  arrange(-FIRE_SIZE) %>%
  select(FIRE_NAME, STATE, FIRE_YEAR, FIRE_SIZE, FIRE_SIZE_CLASS)

# Count the total fire size class during 2012-2015
fire_size_class_count <- fire_2012_2015_df %>%
  group_by(FIRE_SIZE_CLASS) %>%
  count()
colnames(fire_size_class_count) <- c("fire_size_class", "total_number") # Format column names

# Count the total fire in each state during 2012-2015
state_fire_count <- fire_2012_2015_df %>%
  group_by(STATE) %>%
  count() %>%
  arrange(-n)
colnames(state_fire_count) <- c("state", "number_of_fires")