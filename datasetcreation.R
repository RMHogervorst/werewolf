library(lunar) # does things with the moon.
library(dplyr)

lunar.phase()

Sys.setlocale("LC_TIME", "en_US")
# create 100 dates 
set.seed(4957)
dates <- sample(seq(as.Date('1960/01/01'), as.Date('2000/01/01'), by="day"), 100)
werepeople <- data_frame(dates)
#werepeople$weekday <- weekdays(dates)  # does not work so well in non-english locale
werepeople$weekday <- lubridate::wday(dates, label= TRUE)
werepeople$age <- 
# find the moon phase then
werepeople$moonphase <- lunar.phase(dates, name = TRUE)


# if full they are werewolf
# 
# 
sample(seq(as.Date('1960/01/01'), as.Date('2000/01/01'), by="day"), 100)
