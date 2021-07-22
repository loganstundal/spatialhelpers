# US state spatial data to illustrate border distance matrix creation

us <- tigris::states(cb = T, resolution = "20m", year = 2020)

us <- us %>%
  janitor::clean_names() %>%
  filter(!name %in% c("Alaska","Hawaii",
                      "Puerto Rico", "District of Columbia")) %>%
  rename(fips = statefp) %>%
  select(fips, name)

usethis::use_data(us, overwrite = TRUE)
