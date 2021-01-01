#### cov freiburg
library(dplyr)
library(covid19germany)
library(readr)
# load covid data ----
cov_df <- covid19germany::get_RKI_timeseries()

# filter Freiburg ----
fr <- cov_df %>% 
  filter(Landkreis == "SK Freiburg i.Breisgau")

# calculate daily sums ----
fr_daily <- fr %>% 
  group_by(Date) %>% 
  summarize(daily_sum_ill = sum(NumberNewTestedIll),
            daily_sum_dead = sum(NumberNewDead),
            daily_sum_recovered = sum(NumberNewRecovered))

# write to file ----
write_csv(fr_daily, "../public/fr_daily.csv", col_names = T)

