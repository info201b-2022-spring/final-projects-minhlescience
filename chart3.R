# Treemap for Causes of wildfires during 1992-2015

source('./summary_information.R')
library(tidyverse)
library(treemap)
library(dplyr)

# Count the total causes of wildfires during 2012-2015
cause_fire_count <- fires %>%
  group_by(StatCause) %>%
  count()
colnames(cause_fire_count) <- c("cause", "number_of_fires")

treemap(cause_fire_count,
        index="cause",
        vSize="number_of_fires",
        type="index",
        title="Causes of wildfires during 1992-2015",
        inflate.labels=T
)