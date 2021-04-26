## chapter_03-HowDoesRWork.R
#
# This file contains all code examples from chapter 3 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

mean(var1) 

## -- Example 2
#

help(mean)

## -- Example 3
#

var1 <- c(5,3,NA,1,2,NA,3,1,2,4,3,4)   

## -- Example 4
#

mean(var1, trim=0.1, na.rm=TRUE)

## -- Example 5
#

average <- mean(var1, trim=0.1, na.rm=TRUE)

## -- Example 6
#

hourwage <- 34.5

## -- Example 7
#

hourwage

## -- Example 8
#

hourwage <- 343.6

## -- Example 9
#

hourwage_nor <- 343.6

## -- Example 10
#

hourwage_nor <- hourwage*9.96
hourwage_nor

## -- Example 11
#

hourwage_nor <- round(hourwage*9.96)
hourwage_nor

## -- Example 12
#

gender <- "female" # 'female' in single quotes works just as well
gender

## -- Example 13
#

class(gender)

## -- Example 14
#

class(hourwage)

## -- Example 15
#

hourwage <- c(27.0, 33.0, 65.5, 44.5, 15.0)
hourwage

## -- Example 16
#

hourwage1 <- c(27.0, 33.0, 65.5, 44.5, 15.0, 27.7, 33.8, 60.5, 
               41.5, 15.9, 27.9, 33.9, 55.5, 34.5, 45.0, 27.4, 
               63.0, 85.5, 74.5, 15.9, 27.8, 39.0, 85.5, 48.5, 
               75.0)
hourwage1

## -- Example 17
#

gender <- c("male", "female", "male", "male", "female")

## -- Example 18
#

gender

## -- Example 19
#

hourwage*9.96

## -- Example 20
#

log(hourwage)

## -- Example 21
#

hourwage3 <- c(27.0, 33.0, 65.5, 44.5, 15.0, 
               27.7, 33.8, 60.5, 41.5)
hourwage3[4]

## -- Example 22
#

hourwage3[c(2, 5)]

## -- Example 23
#

hourwage3[-c(3, 6)]

## -- Example 24
#

hourwage4 <- hourwage3[-c(3, 6)]

## -- Example 25
#

hourwage4

## -- Example 26
#

hourwage4[c(4,6)] <- c(55.5,44.4)

## -- Example 27
#

hourwage4

## -- Example 28
#

respid <- c(1,2,3,4,5)
hourwage <- c(27.0, 33.0, 65.5, 44.5, 15.0)
age <- c(34, 46, 51, 39, 22)
gender <- c("male", "female", "male", "male", "female")
educ <- c(10, 12, 15, 13, 8)

## -- Example 29
#

data.frame(respid, hourwage, age, gender, educ)

## -- Example 30
#

wage_data <- data.frame(respid, hourwage, age, gender, educ)

## -- Example 31
#

wage_data

## -- Example 32
#

str(wage_data)

## -- Example 33
#

wage_data$age

## -- Example 34
#

age_from_wd <- wage_data$age
age_from_wd

## -- Example 35
#

age_from_wd <- wage_data[ ,3]

## -- Example 36
#

age_from_wd <- wage_data[ ,"age"]
age_from_wd

## -- Example 37
#

hwgen_from_wd <- wage_data[ ,c("hourwage","gender")]

## -- Example 38
#

hwgen_from_wd <- wage_data[ ,c(2,4)]

## -- Example 39
#

hwgen_from_wd

## -- Example 40
#

wage_data[4,]

## -- Example 41
#

wage_data[2:4,]

## -- Example 42
#

wage_data[c(1,4:5),]

## -- Example 43
#

male <- wage_data[ ,"gender"]=="male"
wage_data[male,]

## -- Example 44
#

male

## -- Example 45
#

print(wage_data)
print(wage_data2)

## -- Example 46
#

wage_data_m <- rbind(wage_data, wage_data2)
wage_data_m

## -- Example 47
#

marstat <- c("single","married","married","married","single")

## -- Example 48
#

wage_data_mars <- cbind(wage_data, marstat)
wage_data_mars

## -- Example 49
#

colnames(wage_data)

## -- Example 50
#

colnames(wage_data)[3] <- "alder"

## -- Example 51
#

head(wage_data, 3)

## -- Example 52
#

colnames(wage_data) <- c("respnum","timeloenn","alder",
                         "kjonn","utdann")
head(wage_data,3)

## -- Example 53
#

mat1 <- matrix(1:9, ncol=3)

## -- Example 54
#

mat1

## -- Example 55
#

mat2 <- matrix(1:9, ncol=3, byrow=TRUE)
mat2

## -- Example 56
#

v <- c(200, 345, 500, 100, 444)
d <- data.frame(x1=c(1:5), x2=c(6:10))
m <- matrix(1:9, ncol=3)

## -- Example 57
#

mylist <- list(v, d, m)

## -- Example 58
#

mylist

## -- Example 59
#

mylist[3]

## -- Example 60
#

mylist[[3]]

## -- Example 61
#

m1 <- mylist[3] 

## -- Example 62
#

m1[[1]][8]

## -- Example 63
#

m2 <- mylist[[3]] 

## -- Example 64
#

m2[8]

## -- Example 65
#

m2[2,3]

