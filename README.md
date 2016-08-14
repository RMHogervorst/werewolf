The werewolf dataset
================

[![Licence](https://img.shields.io/badge/licence-cc0-lightgrey.svg)](http://choosealicense.com/) "[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)"

Description of dataset creation
-------------------------------

I needed a dataset with many interesting features, but mostly where I can probabilistically assign people to three categories.

The people in this dataset can be divided into three categories. They are either normal, werewolf, or wererabbit. All 'normal' measures such as haircolor, BMI, eye color, etnicity, BFI values, blood types, favorite food and allergies match the global values of the USA, Age is a random birthday sample. The names come from the babynames package and are selected from the years between 1960 and 1993. So the general values will be equal to the US population. However I only adjusted the hair and eye values for race, other things are not conditional.

Alleged source of the sample
----------------------------

Sunnyville was an unfortunate and freak village. Something happened there. It might have been the radioactive dump nearby, or the spiderfarm on the other side of the village. Or perhaps the experiments 50 years ago had played the vital role.

No one knows what exactly happened, but something had changed the villagers. They were normal on most days, but in the night you would better not be outside. It is a wild place, howling in the night.

There were sightings of large dogs, wolves maybe. And ... rabbits, also very large but mostly fluffy.

Anyway...

Other theories suggest that in an evolutionary race the existence of werewolves should create a pressure and void that must be filled up to balance nature. Thereby creating a healthy counterpart to wolves, namely rabbits.[1]

The research
------------

After a generous donation from the 'astrology-fund-for-research-that-is-really-good' a team of scientists from the university of south-nordistan decided to investigate the village and, since they are social scientist, they decide to measure everything they can measure. It is the day and age of 'quite large'-data they say. The villagers are willing and in the next few weeks they all patiently undergo the questions and measurements. After 2 exciting weeks the scientist return home with their measurements (minus one scientist who could no longer be found).

Unfortunately the funding was not enough to do all the analyses on the dataset. Although very eager, the researchers were not very reproducible in their work. We do not know much about the variables. Their publication was never accepted and most of the research staff went to other jobs in industry. One undergraduate student put the dataset online as an exercise to learn github. An exercise he appantly abandoned, because he is no longer reachable.

### Outcomes

There is a prediction score for three outcomes werewolf, wererabit, normal

### Predictors

Many variables were recorded.

-   dates: date of birth
-   weekday: day of the week of the birth
-   age: whole age at time of recording
-   moonphase: moonphase at time of birth
-   BMI: Body mass index
-   sex: male or female
-   favorite\_food: one of 50
-   allergies : food allergies
-   etnicity: one of white, black or hispanic
-   hair color
-   eye color Big five inventory subscales range 0-10
-   BFI\_O: openness to experience
-   BFI\_C: Conscienciousness
-   BFI\_E: Extraversion
-   BFI\_A: Agreeableness
-   BFI\_N: Neuroticism / stability

-   scratch
-   itch
-   first name
-   coin flip: a measure of luck.
-   blood type

### Licence

This is a CC0 copyright dataset. In other words: you can do with it how you please, but don't hold me responsible.

### Contact

Want to help or have questions?
Contact me directly, use an [issue](https://github.com/RMHogervorst/werewolf/issues), fork me or submit a pull request.

[1] Though these people have no formal biology background and have often seen twilight movies.
