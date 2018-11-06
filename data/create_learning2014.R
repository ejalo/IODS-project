# Elli Jalo
# 6.11.2018
# IODS Exercise 2, data wrangling

# Reading the full learning2014 data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                    sep="\t", header=TRUE)
dim(lrn14)
# Exploring dimensions of the data reveals that there is 183 rows (observations) and 60 column (variables) in the data.
str(lrn14)
# Exploring structure of the data reveals that most the variables are integer variables with values between 1 and 5 (likert scale?).
# In addition to these variables there are variables for age, attitude, points and gender.

# Access the dplyr library
library(dplyr)

# Questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Creating averaged columns (deep, surf, and stra) for deep, surcafe and strategic learning.
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Creating averaged 'attitude' by scaling the column "Attitude" (original variable is a sum of 10 variables).
lrn14$attitude <- lrn14$Attitude / 10

# Creating the new dataset (learning2014) by selecting only the right columns
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Changing the names of columns "Age" and "Points" 
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

# Excluding the participants with 0 points (student did not attend an exam)
learning2014 <- filter(learning2014, points > 0)
str(learning2014)

# Examining the structure of learning2014 data reveals that data has 166 observations and 7 variables as instructed).

# Setting the working directory of this R session to the IODS project folder.
setwd("~/GitHub/IODS-project")

# Saving the dataset to the "data"-folder
write.csv(learning2014, file="~/GitHub/IODS-project/data/learning2014.csv", row.names=FALSE)

# Demonstrating the opening of the data
demonstration <- read.csv("~/GitHub/IODS-project/data/learning2014.csv")
str(demonstration)
head(demonstration)

# Output of the demonstration shows that I was able to open the saved file, and the structure of the saved file was correct (166 observations and 7 variables).