
library(readr)
library(dplyr)

# Source:
# https://data.world/cow/bilateral-trade

cow <- read_csv("data-raw/cow_trade.csv")

cow <- cow %>% filter(year >= 2000)
yrs <- unique(cow$year)


trade <- cow %>%
  filter(year == 2001) %>%
  filter(flow1 != -9,
         flow2 != -9) %>%
  mutate(total_trade = flow1 + flow2) %>%
  select(importer1, importer2,
         flow1, flow2,
         total_trade)

usethis::use_data(trade, overwrite = TRUE)
