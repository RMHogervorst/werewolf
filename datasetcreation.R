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

werepeople$type <- ifelse(werepeople$moonphase == "Full", "werewolf", NA)
# 
# werepeople$value1 <- werepeople$BMI *as.numeric(werepeople$weekday) - as.numeric(werepeople$moonphase)
# werepeople$value2 <- werepeople$BFI_N *werepeople$BFI_O**werepeople$value3
# werepeople$value3 <- rnorm(N_people)
# werepeople$value4 <- werepeople$value1+werepeople$value2+werepeople$value3
# werepeople$type[werepeople$value3 <0] <- as.factor(ifelse(werepeople$value4 >=100, "normal",
#                            ifelse(werepeople$value3 >0.3, "werewolf", "wererabbit")))
# werepeople$typewerepeople$type[werepeople$value3 >=0] <- sample(c("normal", "werewolf", "wererabbit"),
#                                                                 size = length(werepeople$typewerepeople$type[werepeople$value3 >=0]),
#                                                                 replace = TRUE,prob = c(2,1,1))
werepeople$type <- NA
# if favorite food is Bacon or Steak and moon is full during birth werewolf
werepeople$type[(werepeople$favorite_food == "Bacon"| werepeople$favorite_food == "Steak") & werepeople$moonphase =="Full"] <- "werewolf"
# if favorite food is blueberries, apples, banana, sweetcorn and age <30 wererabbit
werepeople$type[(werepeople$favorite_food %in% c("Blueberries", "Apples", "Banana", "Sweetcorn")) & werepeople$age <30] <- "wererabbit"
# if BMI <20 favorite food is Peanut butter/Popcorn wererabbit
werepeople$type[werepeople$BMI <20 & werepeople$favorite_food %in% c("Peanut Butter", "Popcorn")] <- "wererabbit"
# if favorite food is watermelon normal
werepeople$type[werepeople$favorite_food == "Watermelon"] <- "normal"
# brown eyes and brown hair and blood type A- or B- werewolf
werepeople$type[werepeople$haircolor == "brown" & werepeople$eye_color =="brown" & werepeople$blood_type %in% c("A-","B-")] <- "werewolf"
# if born on sunday and nchar first name 8 > normal
werepeople$type[werepeople$weekday == "Sun" & nchar(werepeople$first_name)>7] <- "normal"
werepeople$type[is.na(werepeople$type) & werepeople$BFI_E <2] <- "normal"
werepeople$type[is.na(werepeople$type) & werepeople$BFI_O <3] <- "wererabbit"
werepeople$type[is.na(werepeople$type) & werepeople$BFI_A >4] <- "werewolf"
werepeople$type[is.na(werepeople$type)] <- "normal"
table(werepeople$type)
#################creation of probabilities.
#vglm(formec.domainTOTAALn, family=multinomial(refLevel=2), data=datac1domecTOTAAL)
#formulaprediction <- type~moonphase+weekday+ age + scratch + allergies + eye_color +sex +blood_type
formulaprediction <- type~moonphase+weekday+ age + scratch + eye_color +sex +blood_type+BFI_N

library(VGAM)
predictie <- vglm(formula = formulaprediction,
     family =multinomial(refLevel=1),
     data = werepeople)
#summary(predictie)
values <- predict(predictie, werepeople)

noemer <- 1+ exp(values[,1])+ exp(values[,2])
normal <- exp(values[,1])/noemer
wererabbit <- exp(values[,2])/noemer
werewolf <- 1/noemer
wolfies <- cbind(normal,wererabbit, werewolf)


#wolfies$choose <- max.col(wolfies[,1:3])
#rowSums(wolfies)
# cbind(werepeople,wolfies) %>% select(type,normal, wererabbit) %>% 
#     View

werepeople_dataset <- cbind(werepeople,wolfies) %>% select(-type)
saveRDS(werepeople_dataset, "data/werepeople.RDS")
