# Exercise 6 / Data wrangling
# Elli Jalo
# 7.12.2018

# Step 1: Loading the datasets (BPRS and RATS) from source in the WIDE form

# Reading the datasets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T)

names(BPRS)
names (RATS)

str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)


# Step 2: Converting the categorical variables of both sata sets to factors

#In BRPS variables 'treatment' and 'subject' are categorical

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# In RATS, variables 'ID' and 'Group' are categorical

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Step 3: Converting the data sets to LONG form

library(dplyr); library(tidyr)

# Converting the BPRS data 
BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>% #converting the data
  mutate(week = as.integer(substr(weeks,5,5))) #adding a 'week' variable, with week numbers as values

# Convert data the RATS data
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>% #converting the data
  mutate(Time = as.integer(substr(WD,3,4))) #adding a "Time variable with days as values


# Step 4: Taking serious look at new data sets

dim(BPRSL)
names(BPRSL)

# The new BPRSL data which in LONG form, contains 360 observations and 5 variables
# The orginal BPRS data in WIDE form contained 40 observations and 11 variables
# In the original BPRS data, there was only one row for each participants and BPRS scores from different weeks were separate variables
# In the new BPRSL data, there is several rows for each participants (one row for each week)
# In the new BPRSL data, there is only one variable (bprs) for BPRS scores

dim(RATSL)
names(RATSL)
# In the new RATSL data in LONG form there are 176 observarions and 5 variables
# The original RATS data contained 16 observations and 13 variables
# Same as conversion has happened as with BPRS data
# The new RATSL data has several rows for each rat, namely each rat has 11 rows representing each measurement point
# In the dataset, there is only one variable for weight, 
# whereas in the original WIDE form data there were 11 variables for weight in each measurement point.

# Saving the wrangled data into my IODS-project data-folder

write.csv(BPRSL, file="~/GitHub/IODS-project/data/BPRSL.csv", row.names=FALSE)

write.csv(RATSL, file="~/GitHub/IODS-project/data/RATSL.csv", row.names=FALSE)

 