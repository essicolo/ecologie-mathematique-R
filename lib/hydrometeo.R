library("weathercan")
library("tidyverse")
library("lubridate")
library("tsibble")
library("fable")
hydro <- read_csv("data/023402_Q.csv")
meteo <- weather_dl(station_ids = 27377, start = "1998-01-01", end = "2018-01-07", interval = "day")
meteo <- meteo %>% rename(Date = date)
hydrometeo <- left_join(hydro, meteo, by = "Date")
save(hydrometeo, file = "data/09_hydrometeo.RData")


hydrometeo <-hydrometeo %>% 
  filter(Date >= ymd("1998-01-01"), Date < ymd("2018-01-01")) %>% 
  select(Date, `Débit`, total_precip, mean_temp)

library(VIM)
summary(aggr(hydrometeo, sortVar = TRUE))

hydrometeo_mv <- hydrometeo %>% 
  fill(`Débit`, total_precip, mean_temp, .direction = "down")

summary(aggr(hydrometeo_mv, sortVar = TRUE))

hm_arima <- hydrometeo_mv %>% 
  as_tsibble(index = Date) %>% 
  model(ARIMA(`Débit` ~ total_precip + mean_temp + season("year")))
