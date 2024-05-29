#load Packages
library(tidyverse)
library(skimr)
library(naniar)

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
startwars