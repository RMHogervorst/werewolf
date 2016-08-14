#probabilities based on how I like it.

# table(werepeople$type)
# werepeople$identifier <- sample(1:1000, size = N_people,replace = FALSE)
# so we can match them up later on.
uniformall <- seq(0.01, 0.98,by = .01)
uniformmid <- rep(seq(0.30, 0.60,by = .01),2)
uniformhigh <-rep(seq(0.70, 0.90,by = .01),2)
gausian <- rnorm(20, .8,.2)
everything <- c(uniformall, uniformhigh, uniformmid, gausian)
everything <- everything[everything >0 & everything <1]
#hist(everything, breaks = 30)
werepeople$normal <- NA
werepeople$werewolf <- NA
werepeople$wererabbit <- NA
werepeople$normal[werepeople$type== "normal"] <- sample(everything, 
                                                        length(werepeople$normal[werepeople$type== "normal"]),
                                                        replace = TRUE)
werepeople$werewolf[werepeople$type == "werewolf"] <- sample(everything, 
                                                             length(werepeople$werewolf[werepeople$type== "werewolf"]),
                                                             replace = TRUE)
werepeople$normal[is.na(werepeople$normal)] <- sample(uniformmid, 
                                                      size = sum(is.na(werepeople$normal)),
                                                      replace = TRUE)
werepeople$werewolf[is.na(werepeople$werewolf)] <- sample(uniformmid, 
                                                      size = sum(is.na(werepeople$werewolf)),
                                                      replace = TRUE)
#werepeople$werewolf[sum(werepeople$normal, werepeople$werewolf)>1] <- 
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal 
werepeople$werewolf[werepeople$wererabbit >1] <- .20
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal

# sum(is.na(werepeople$werewolf))
# sum(is.na(werepeople$normal))
# plot(werepeople$normal, werepeople$werewolf)
# plot(werepeople$normal, werepeople$wererabbit)
# plot(werepeople$werewolf, werepeople$wererabbit)
# hist(werepeople$normal)
# hist(werepeople$wererabbit)
# hist(werepeople$werewolf)
werepeople$werewolf[werepeople$werewolf <.4 & werepeople$coinflip=="heads"] <- sample(uniformhigh,
                                                                                      size = length(werepeople$werewolf[werepeople$werewolf <.4 & werepeople$coinflip=="heads"]) ,
                                                                                             replace= TRUE)
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
werepeople$werewolf[werepeople$wererabbit >1] <- .20
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal

plot(density(werepeople$normal[werepeople$type=="normal"]))
plot(density(werepeople$normal[werepeople$type!="normal"]))
plot(density(werepeople$werewolf[werepeople$type=="werewolf"]))
plot(density(werepeople$werewolf[werepeople$type!="werewolf"]))
plot(density(werepeople$wererabbit[werepeople$type=="wererabbit"]))
plot(density(werepeople$wererabbit[werepeople$type!="wererabbit"]))

werepeople$werewolf[werepeople$wererabbit <0 & werepeople$coinflip=="heads"] <- sample(1-uniformhigh,
                                                                                         size = length(werepeople$wererabbit[werepeople$wererabbit <0 & werepeople$coinflip=="heads"]) ,
                                                                                         replace= TRUE)
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
werepeople$normal[werepeople$wererabbit <0 & werepeople$coinflip=="tails"] <- sample(1-uniformhigh,
                                                                                     size = length(werepeople$normal[werepeople$wererabbit <0 & werepeople$coinflip=="tails"]) ,
                                                                                     replace= TRUE)
#sum(werepeople$wererabbit <0)
#sum(werepeople$wererabbit >1)
# sum(werepeople$werewolf >1)
# sum(werepeople$werewolf <0)
# sum(werepeople$normal <0)
werepeople$normal[werepeople$wererabbit <0] <- werepeople$normal[werepeople$wererabbit <0] -.1
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
werepeople$werewolf[werepeople$wererabbit <0] <- werepeople$werewolf[werepeople$wererabbit <0] -.1
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
werepeople$normal[werepeople$wererabbit <0] <- werepeople$normal[werepeople$wererabbit <0] -.05
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
werepeople$normal[werepeople$wererabbit <0] <- werepeople$normal[werepeople$wererabbit <0] -.05
werepeople$wererabbit <- 1-werepeople$werewolf-werepeople$normal
# saving file
werepeople_dataset <- werepeople %>%  select(-type)
saveRDS(werepeople_dataset, "data/werepeople.RDS")
