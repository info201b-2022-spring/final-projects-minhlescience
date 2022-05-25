# Treemap for Causes of wildfires during 1992-2015

source('./summary_information.R')
library(tidyverse)
library(ggplot2)
library(dplyr)

# This file deals with charts associated with Fire Sizes & Fire Size Classes

fire_size_class_bar = ggplot(fires_by_fire_size_class, aes(x=FireSizeClass, y=Count)) +
  geom_col() +
  ggtitle('Fire Counts in US for Each Fire Size Class during 1992-2015') +
  xlab('Fire Size Class')

fire_size_class_progression = ggplot(fires_by_fire_size_class_and_year, aes(x=FireYear, y=Count, group=FireSizeClass, color=FireSizeClass)) +
  geom_line() +
  geom_point() +
  ggtitle('Fire Count Progression in US during 1992-2015 for Each Fire Size Class') +
  xlab('Year') +
  ylab('Fire Counts')
