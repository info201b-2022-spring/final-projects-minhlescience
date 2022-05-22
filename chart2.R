# Treemap for Causes of wildfires during 1992-2015

source('./summary_information.R')
library(tidyverse)
library(ggplot2)
library(dplyr)

# Count the total causes of wildfires during 2012-2015
fire_size_count <- fires %>%
  group_by(FireSizeClass) %>%
  count()
colnames(fire_size_count) <- c("size", "number_of_fires")

# Barplot
ggplot(fire_size_count, aes(x=size, y=number_of_fires)) + 
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() +
  ggtitle("Wildfires size class during 1992-2015") +
  xlab("Size Class") +
  ylab("Number of Wildfires")
