# calculations of probabilities based on VGAM
# 
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
