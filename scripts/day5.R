install.packages("skimr")


library(tidyverse)
library(skimr)

#data
install.packages("gapminder")
library(gapminder)

#Data inspection

#examine first few rows
head(gapminder)

#examine first few rows
tail(gapminder, n=10)

#sampling

sample_n(gapminder,10)

#Fraction
sample_frac (gapminder, 0.25)

#Dimension
dim(gapminder)
ncol(gapminder)
nrow(gapminder)

#Data Structure
glimpse(gapminder)


#Handling missing Values
#1.Check missing values
is.na(gapminder)
is.na(airquality)

#How many?
sum(is.na(gapminder))
sum(is.na(airquality))

#Which Columns?
colSums(is.na(gapminder))
colSums(is.na(airquality))

#is there any duplicated rows
duplicated(gapminder)
duplicated(airquality)
sum(duplicated(gapminder))
sum(duplicated(airquality))

#Summary Functions

summary(gapminder)
skim(gapminder)


#Data Manipulation

#Select
#1. pick single column by name

select(gapminder,country)
#2. pick multiple column by name

select(gapminder,country,continent)
#3. pick single column by column number

select(gapminder,1)
#4. pick multiple column by col. number

select(gapminder, c(2,4))

# 5. Pick column by range(colon operator)

select(gapminder, 1:4)
# 6. pick column starts with func.
select(gapminder, starts_with("y"))

# 7. # 6. pick column ends with func.
select(gapminder, ends_with("p"))

# 8. pick col using contains func

select(gapminder, contains("c"))

#Filter
head(gapminder)

#equality

filter(gapminder, "country == Bangladesh")