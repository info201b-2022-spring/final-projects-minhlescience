library(sqldf)
library(dplyr)
library(ggplot2)

con <- dbConnect(RSQLite::SQLite(), './data/FPA_FOD_20170508.sqlite');

fires_by_state <- dbFetch(dbSendQuery(con, 'select State, count(*) as Fire_Count from fires group by State order by Fire_Count'));

fires_by_year <- dbFetch(dbSendQuery(con, 'select FIRE_YEAR, count(*) as Fire_Count from fires group by FIRE_YEAR order by FIRE_YEAR'));

year_with_max_fires_row = fires_by_year[which.max(fires_by_year$Fire_Count),];
year_with_max_fires = year_with_max_fires_row$FIRE_YEAR;
year_with_max_fires_fire_count = year_with_max_fires_row$Fire_Count;

fires <- dbFetch(dbSendQuery(con, 'select STATE, COUNTY, LATITUDE, LONGITUDE, FIRE_YEAR, FOD_ID from fires groupt'));

state_year <- fires %>%
  group_by(STATE, FIRE_YEAR) %>%
  count()
state_year <- as.data.frame(state_year)

max_year_progression = state_year %>% 
  group_by(FIRE_YEAR) %>% 
  summarise(max_fire_count = state_year[which.max(state_year[FIRE_YEAR == state_year$])])

max_year_progression_1 <- state_year %>% 
  group_by(FIRE_YEAR) %>%
  slice(which.max(n))

progession_by_year <- ggplot(data = fires_by_year, aes(x = FIRE_YEAR, y = Fire_Count, group = 1)) + 
  geom_line() +
  geom_point()

progession_by_state_year <- ggplot(data = state_year, aes(x = FIRE_YEAR, y = n, group = STATE)) + 
  geom_line() +
  geom_point()











