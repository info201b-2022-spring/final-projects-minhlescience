# Summary Information Script

library(tidyverse)
library(ggplot2)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# Count the total fire in each state during 2012-2015
state_fire_count <- fire_2012_2015_df %>%
  group_by(STATE, FIRE_YEAR) %>%
  count()
colnames(state_fire_count) <- c("state", "year", "number_of_fires")

# Make a table of fires in Texas, California, Oregon, Washington
tx_ca_or_wa <- state_fire_count %>%
  filter(state %in% c("TX", "CA", "OR", "WA"))

# Plot
tx_ca_or_wa %>%
  ggplot( aes(x=year, y=number_of_fires, group=state, color=state)) +
  geom_line() +
  ggtitle("Number of fires among states in 2012-2015") +
  ylab("Number of fire")
