# Chart 3 for Barplot

library(tidyverse)
library(ggplot2)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# Count the total causes of wildfires during 2012-2015
cause_fire_count <- fire_2012_2015_df %>%
  group_by(STAT_CAUSE_DESCR) %>%
  count()
colnames(cause_fire_count) <- c("cause", "number_of_fires")

cause_fire_count %>%
  ggplot( aes(x=cause, y=number_of_fires)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() +
  ggtitle("Causes of wildfires during 2012-2015") +
  xlab("") +
  ylab("Number of wildfires") +
  theme_bw()
