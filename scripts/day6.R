#load Packages
library(tidyverse)
library(skimr)
library(naniar)
library(stringr)

#Finding missing values

test <- c(0, NA , -1)
test
test2 <- test/0
 #Look for na

is.na(test)
sum(is.na(test))

#look for nan
is.nan(test)
is.nan(test2)
sum(is.nan(test2))

#Look for inf

is.infinite(test2)
sum(is.infinite(test2))

#Any function
any(is.na(test2))

#starwars

starwars
names(starwars)
#Check missing
any(is.na(starwars))

#Count NA/missing values

starwars |> 
  count(sex)

#pct_complete
starwars |> 
  select(gender) |> 
  pct_complete()

#miss_var_summary()
#miss_var_summary(starwars)

#gg_miss_var
#gg_miss_var(starwars)

#missing data issues
mean(c(1,2,3,NA))
median(c(1,2,3,NA))
sum(c(1,2,3,NA))

#removing data issues
mean(c(1,2,3,NA) , na.rm = T)
median(c(1,2,3,NA) , na.rm = T)
sum(c(1,2,3,NA) , na.rm = T)

#filter and missing data

starwars |> 
  filter(sex == "male" | is.na(sex) )

#Check entire dataset missing values
sum(is.na(starwars))
#check dimension
dim(starwars)
#drop missing values
Starwars_drop <- drop_na(starwars)
#check dimension again
dim(Starwars_drop)
#plotting after removing NA
gg_miss_var(starwars)
gg_miss_var(starwars_drop)

#drop_columns

miss_var_summary(starwars)
miss_var_which(starwars)

#remove missing values column
starwars |> 
  select(!miss_var_which(starwars))

#Change a value to be NA
starwars |> 
  mutate(gender = na_if(gender ,"99"))

miss_var_summary(starwars)

#dealing with missing values

glimpse(starwars)

starwars_updated <- starwars |> 
  mutate_if(is.character, as.factor)


glimpse(starwars_updated)
#Numeric - Imputation(mean ,median)
#mean
mean(starwars$height , na.rm =T)

starwars_new = starwars |> 
  mutate(height = replace_na(mean(height,na.rm = T)))

miss_var_summary(starwars_new)

#median
median(starwars$height , na.rm =T)

starwars_new = starwars |> 
  mutate(height = replace_na(median(height,na.rm = T)))

miss_var_summary(starwars_new)


# categoriacal - imputation (replacing missing vales)frequency , mode(most frequent value)

starwars |> 
  count(gender) |> 
  arrange(desc(n))

starwars_3 <- starwars |> 
  mutate(gender = replace_na("masculine"))

miss_var_summary(starwars_3)

#reading diet data

diet_data <- readxl::read_excel("C:/Users/KAISER/Desktop/Chiral/PH/AMR_Parental_RFR/raw_data/cleaning_diet_data.xlsx")

diet_data |> 
  count(Treatment)

diet_data |> 
  mutate(Treatment = case_when(
    Treatment == "O" ~ "Other",
    Treatment == "Other" ~ "Other",
    Treatment == "Ginger" ~ "Ginger",
    Treatment == "mint" ~"Peppermint",
    Treatment == "Mint" ~"Peppermint",
    Treatment == "peppermint" ~"Peppermint"
  )) |> 
  count(Treatment,Treatment)

#More efficient

diet_data |> 
  mutate(Treatment = case_when(
    Treatment == "Ginger" ~ "Ginger",
    Treatment %in% c("mint","Mint","peppermint","Peppermint")~"Peppermint",
    Treatment %in% c("O","Other") ~ "Other"
  )) |> 
  count(Treatment)

data_diet <- diet_data |> 
  mutate(Effect = case_when(
    Weight_change > 0  ~ "Increase",
    Weight_change < 0  ~ "Decrease",
    Weight_change == 0  ~ "Same"
  ))
head(data_diet)


#str_detect
data_diet |> 
  filter(str_detect(string =Effect,pattern="D"))

data_diet |> 
  filter(str_detect(string =Effect,pattern="I"))

data_diet |> 
  filter(str_detect(string =Effect,pattern="S"))


#Detect and Replace

data_diet |> 
  mutate(Treatment_Recod = case_when(
    str_detect(string = Treatment , pattern = "int")~ "Peppermint",
    str_detect(string =Treatment,pattern ="o^O^")~ "Other",
    TRUE ~ Treatment
  ))