library("tidyverse")
library("weathercan")

stations_box <- stations %>% 
  filter(lat > 45, lat < 50, lon < -60, lon > -80,
         start <= 2018, interval %in% c("hour", "day"),
         end >= 2018)

weather_box <- weather_dl(station_ids = stations_box$station_id,
                         start = "2018-05-01",
                         end = "2018-05-30",
                         interval = "day")

suma = function(x) if (all(is.na(x))) x[NA_integer_] else sum(x, na.rm = TRUE) # https://stackoverflow.com/questions/41470277/sum-non-na-elements-only-but-if-all-na-then-return-na#41475155

weather_summary <- weather_box %>% 
  mutate(degree_day = ifelse(mean_temp > 5, mean_temp, 0)) %>% 
  group_by(station_id, station_name, station_id, prov, lat, lon) %>% 
  summarise(degree_days = suma(degree_day), cumul_precip = suma(total_precip))

sdi_summary <- weather_box %>% 
  left_join(weather_summary, by = "station_id") %>% 
  mutate(prop_precip = total_precip/cumul_precip) %>% 
  group_by(station_id) %>% 
  summarise(sdi = -suma(prop_precip * log(prop_precip)/log(30)))

weather_summary <- weather_summary %>% 
  left_join(sdi_summary, by = "station_id")

write_csv(x = weather_summary, path = "data/12_weather.csv")

