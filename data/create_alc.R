# Elli Jalo
# 17.11.2018
# IODS Exercise 3, data wrangling, data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance

#Step 3: Reading the both datasets (por and math) and exploring the structure and dimensions

math <- read.table("~/GitHub/IODS-project/data/student-mat.csv", sep = ";", header = TRUE)
por <- read.table("~/GitHub/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

dim(math)
dim (por)

#Both datasets contain 33 variables, Math contains 395 rows and po 649 rows

str(math)
str(por)

#The variable names seems to be same in both datasets

#Step 4: Joining the two datasets

library(dplyr)

# selecting the identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# joining the two datasets by the selected identifiers with inner join (inner join function keeps only the students present in both datasets)
math_por <- inner_join(math, por, by = join_by, suffix=c("math","por"))

#examining the dimensions of the joined data
dim(math_por)

#There are 53 variables and 382 rows (students) in the joined data

#Step 5: Combining the "duplicate" answers in the joined data by using if-else structure suggested in the DataCamp exercise
#If answers are numeric --> mean value is calculated for the joined data
#If answers are categorical --> First value is selected

# creating a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# selecting the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

dim(alc)

#In joined acl-data, there are 33 variables and 382 observation

#Step 6: creating the variables alc_use and high_use

# creating alc_use by averaging weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# creating a logical high_use variable (TRUE if alc_use > 2) 
alc <- mutate(alc, high_use = alc_use > 2)

#Step 7: Checking the data and saving it with write.csv
glimpse(alc)

#The joined and modified acl-data contains 35 variables and 382 observations as it should
#It contains also the new created variables alc_use and high_use
#Everything seems to be in order

# Saving the dataset to the "data"-folder
write.csv(alc, file="~/GitHub/IODS-project/data/alc.csv", row.names=FALSE)
