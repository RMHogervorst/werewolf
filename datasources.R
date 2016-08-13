#### datasources
#### 
library(babynames)
suppressPackageStartupMessages(library(dplyr))
#favourite food:
#according to this very reputable news source (who don't bother to read
#their own report and see that asparagus is twice in the list... 41 and26) 
# this is what people like in the united states
#http://www.dailymail.co.uk/femail/article-2788395/pass-protein-america-s-50-favorite-foods-revealed-steak-chicken-topping-list.html
favorite_foods <- c("Steak", "Chicken", "Pizza", "Waffles", "Beef", 
                    "Mozzarella-cheese", "Bacon", "Corned Beef", "Avocado",
                    "Pasta", "Pineapple", "Peanut Butter", "Hamburgers", 
                    "Sushi","Pancakes", "Noodles", "Chocolate", "Blueberries",
                    "Salmon", "Banana", "Ice Cream", "Ham", "Oysters", 
                    "Mashed potatoes", "Soup", "Asparagus", "Sweet potato",
                    "Donuts", "Turkey", "Candy", "Grapes", "Popcorn", "Cashwew nuts",
                    "Eggs", "Watermelon", "Tuna", "Cheddar cheese", "Prawns",
                    "Strawberries", "Artichokes", "Halibut", "Almonds",
                    "Mango", "Meatballs", "Apples", "Lamb", "Sweetcorn",
                    "Mushrooms", "Rice pudding")
# according to FARE http://www.foodallergy.org/facts-and-stats
# These 8 foods are responsible for 90 % of food allergies
common_allergies <- c("cow's milk", "eggs", "peanuts", "fish", 
                      "tree nuts (such as cashews or walnuts)", "wheat", "soy", NA)
#http://www.gnxp.com/blog/2008/12/nlsy-blogging-eye-and-hair-color-of.php
#I only took the male colors.
haircolors_white <- sample(c("light blond", "blond","light brown", "brown", "black", "red", "grey"), 
                           1000,replace = TRUE,
                           c(1.18,15.31,14.68,57.97,7.6,3.19,0.07))
haircolors_black <- sample(c("light blond", "blond","light brown", "brown", "black", "red", "grey"), 
                           1000,replace = TRUE,
                           c(.14,0,.85,13.15,85.08,.71,.01))
haircolors_hispanic <- sample(c("light blond", "blond","light brown", "brown", "black", "red", "grey"), 
                           1000,replace = TRUE,
                           c(0,1.1,2.97,46.86,48.51,.55,0))
eye_color_white <- sample(c("light blue", "blue", "light brown","brown",
                            "black", "green", "hazel", "grey", "other"),
                          1000, replace = TRUE, 
                          c(1.12, 34.49, .71, 33.50, .46, 13.14,15.18,.82, .56))
eye_color_black <- sample(c("light blue", "blue", "light brown","brown",
                            "black", "green", "hazel", "grey", "other"),
                          1000, replace = TRUE, 
                          c(.14,.49,1.2,84.66,11.94,.21,.99,.28,.07))
eye_color_hispanic <- sample(c("light blue", "blue", "light brown","brown",
                            "black", "green", "hazel", "grey", "other"),
                          1000, replace = TRUE, 
                          c(0,2.75,1.87,79.54,6.71,4.18,4.63,.11,.22))

male_names <- babynames %>% 
    filter(sex == "M") %>% 
    filter(year>1960 & year< 1993) %>% 
    arrange(desc(prop)) %>% 
    .$name
female_names <- babynames %>% 
    filter(sex == "F") %>% 
    filter(year>1960 & year< 1993) %>% 
    arrange(desc(prop)) %>% 
    .$name
# source: took the usa : https://en.wikipedia.org/wiki/Blood_type_distribution_by_country
blood_type <- sample(c("O+", "A+", "B+", "AB+", "O-", "A-", "B-", "AB-"), 
                     1000, replace = TRUE,
                     c(37.4,35.7,8.5,3.4,6.6,6.3,1.5,.06))
    #37.4% 	35.7% 	8.5% 	3.4% 	6.6% 	6.3% 	1.5% 	0.6%
#table(blood_type)
