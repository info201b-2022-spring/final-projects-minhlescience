library(sqldf)

sql = '
select 
  STATE as State, 
  COUNTY as County, 
  LATITUDE as Latitude, 
  LONGITUDE as Longitude, 
  FIRE_YEAR as FireYear, 
  FIRE_SIZE as FireSize, 
  FIRE_SIZE_CLASS as FireSizeClass, 
  FOD_ID as Id 
from fires
'
con <- dbConnect(RSQLite::SQLite(), './data/FPA_FOD_20170508.sqlite')
fires <- dbFetch(dbSendQuery(con, sql))
dbDisconnect(con)

summary_info <- list()
summary_info$total_fire_record_count = count(fires)$n
summary_info$max_fire_size = max(fires$FireSize)
summary_info$min_fire_size = min(fires$FireSize)
summary_info$mean_fire_size = mean(fires$FireSize)
summary_info$fire_size_class_count = length(unique(fires$FireSizeClass))
summary_info$start_year = min(fires$FireYear)
summary_info$end_year = max(fires$FireYear)