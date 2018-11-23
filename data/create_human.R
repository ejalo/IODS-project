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