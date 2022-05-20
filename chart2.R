# Summary Information Script

library(tidyverse)
library(treemap)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# Count the total fire size class during 2012-2015
fire_size_class_count <- fire_2012_2015_df %>%
  group_by(FIRE_SIZE_CLASS) %>%
  count()
colnames(fire_size_class_count) <- c("fire_size_class", "total_number") # Format column names

treemap(fire_size_class_count,
        index="fire_size_class",
        vSize="total_number",
        type="index",
        title="Wildfire size class",
        inflate.labels=T
)
