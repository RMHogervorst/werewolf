library(lunar) # does things with the moon.
library(dplyr)
library(lubridate)

#Sys.setlocale("LC_TIME", "en_US")
# create 100 dates 
N_people <- 500
# 
set.seed(4957)
dates <- sample(seq(as.Date('1960/01/01'), as.Date('2000/01/01'), by="day"), N_people)
werepeople <- data_frame(dates)
#werepeople$weekday <- weekdays(dates)  # does not work so well in non-english locale
werepeople$weekday <- lubridate::wday(dates, label= TRUE)
# let's add their age at a certain point in time.
werepeople$age <- as.integer(floor((as.Date('2016-08-01')-werepeople$dates)/365.25))
# find the moon phase during date of birth
werepeople$moonphase <- lunar.phase(dates, name = TRUE)
# if full they are werewolf
werepeople$BMI <- rnorm(N_people, 26.5, 7.1)
werepeople$sex <- sample(c("male", "female"),N_people, replace = TRUE)
werepeople$favorite_food <- sample(favorite_foods, N_people, TRUE)
# add food allergies, approx 4% of people
werepeople$allergies <- sample(common_allergies, N_people, replace = TRUE, c(2, rep(4, 6),N_people))
#according to wikipedia and oversimplifying this a bit
#white 64 %, black 12% hispanic/latino 16  rest will be other.
werepeople$ethnicity <- sample(c("white", "black", "hispanic"),
                               N_people, replace = TRUE, 
                               c(64,12,16))
werepeople$haircolor <- ifelse(werepeople$ethnicity == "white", 
                               sample(haircolors_white, N_people, replace = FALSE),
                        ifelse(werepeople$ethnicity == "black",
                               sample(haircolors_black, N_people, replace = FALSE),      
                               sample(haircolors_hispanic, N_people, replace = FALSE)))
werepeople$eye_color <- ifelse(werepeople$ethnicity == "white", 
                               sample(eye_color_white, N_people, replace = FALSE),
                               ifelse(werepeople$ethnicity == "black",
                                      sample(eye_color_black, N_people, replace = FALSE),      
                                      sample(eye_color_hispanic, N_people, replace = FALSE)))
werepeople$BFI_O <- rnorm(N_people, 3.88, .70)
werepeople$BFI_C <- rnorm(N_people, 3.63, .72)
werepeople$BFI_E <- rnorm(N_people, 3.22, .93)
werepeople$BFI_A <- rnorm(N_people, 3.90, .60)
werepeople$BFI_N <- rnorm(N_people, 3.19, .84)
werepeople$scratch <- sample(1:7, N_people, replace = TRUE)
werepeople$itch <- sample(1:7, N_people, replace = TRUE)
werepeople$coinflip <- sample(c("heads", "tails"), N_people, replace = TRUE)
werepeople$blood_type <- sample(blood_type, N_people)
werepeople$first_name <- ifelse(werepeople$sex == "female", 
                                sample(female_names, N_people),
                                sample(male_names, N_people))

#werepeople$type <- ifelse(werepeople$moonphase == "Full", "werewolf", NA)

werepeople$value1 <- werepeople$BMI *as.numeric(werepeople$weekday) - as.numeric(werepeople$moonphase)
werepeople$value2 <- werepeople$BFI_N *werepeople$BFI_O**werepeople$value3
werepeople$value3 <- rnorm(N_people)
werepeople$value4 <- werepeople$value1+werepeople$value2+werepeople$value3
werepeople$type <- ifelse(werepeople$value4 >=100, "normal",
                          ifelse(werepeople$value3 >0.3, "werewolf", "wererabbit"))
