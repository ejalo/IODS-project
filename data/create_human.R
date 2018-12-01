# Elli Jalo
# 23.11.2018
# Exercise 4, data wrangling

# reading the datasets

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# exploring the structure and dimensions of the datasets

str(hd)
str(gii)

dim(hd)
dim(gii)

# in hd, there is 195 observations and 8 variables
# in gii, there is 195 observations and 10 variables

# Renaming the column names

library(dplyr)
colnames(hd) <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
colnames(gii) <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")      

# creating new variables
gii <- mutate(gii, Edu2.FM = Edu2.F/Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F/Labo.M)

# joining together two datasets using the variable Country as identifier
human <- inner_join(hd, gii, by = "Country")

# Saving the dataset to the "data"-folder
write.csv(human, file="~/GitHub/IODS-project/data/human.csv", row.names=FALSE)

# testing that the data opens
# Demonstrating the opening of the data
test<- read.csv("~/GitHub/IODS-project/data/human.csv")
str(test)
dim(test)

# test/human dataset has 195 observations and 19 variables. It is likely that the creating the dataset went right.





# Exercise 5 / Data wrangling 
# Elli Jalo / 1.12.2018
# I continue working with this same create_human.R from the last week

# 1.  Transforming the Gross National Income (GNI) variable to numeric

library(stringr)

human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# 2. Excluding the unneeded variables

library(dplyr)

human <- select(human, c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", 
                         "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))

# 3. Removing all rows with missing values

human <- filter(human, complete.cases(human))

# 4. Removing the observations which relate to regions instead of countries 
# (the 7 last observations according to DataCamp)

# defining the last row we want to keep
last <- nrow(human) - 7

# choosing everything until the last 7 observations
human <- human[1:last, ]

# 5. Setting country names as row names and overwriting the human.sav -data

# adding countries as rownames 
rownames(human) <- human$Country

# removing the country name column by selecting all columns except rowname

human <- select(human, -Country)

dim(human)

# As instructed, there are 155 observations and 8 variables in the human-data.

# Saving the dataset to the "data"-folder 
write.csv(human, file="~/GitHub/IODS-project/data/human.csv", row.names=FALSE)

# testing that the data opens
# Demonstrating the opening of the data
test_ex5<- read.csv("~/GitHub/IODS-project/data/human.csv")
str(test_ex5)
dim(test_ex5)



