## chapter_02-ImportWorkWithR.R
#
# This file contains all code examples from chapter 2 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

semicol_sep_data <- read.table("semicol_sep_data.txt", 
                               header=TRUE, sep=";")

## -- Example 2
#

View(semicol_sep_data)

## -- Example 3
#

csv_data <- read.table("csv_data.csv", header=TRUE, sep=",")       

## -- Example 4
#

slash_sep_data <- read.table("slash_sep_data.txt", 
                             header=TRUE, sep="/")  

## -- Example 5
#

install.packages("readxl")  

## -- Example 6
#

library(readxl)

## -- Example 7
#

excel_data <- read_excel("excel_data.xlsx")	

## -- Example 8
#

excel_data2 <- read_excel("excel_data.xlsx", sheet=2)	

## -- Example 9
#

install.packages("haven")

## -- Example 10
#

library(haven)

## -- Example 11
#

spss_data <- read_spss("spss_data.sav")	

## -- Example 12
#

stata_data <- read_stata("stata_data.dta") 

## -- Example 13
#

save(wage_women, file="mydata.Rdata")

## -- Example 14
#

load(file="mydata.Rdata")

## -- Example 15
#

wage_data <- data.frame(respid=numeric(0), 
                        hwage=numeric(0),    
                        age=numeric(0), 
                        gender=character(0), 
                        educ=numeric(0))  

## -- Example 16
#

fix(wage_data)

## -- Example 17
#

respid <- c(1, 2, 3, 4, 5)
hwage  <- c(27.0, 33.0, 65.5, 44.5, 15.0)
age    <- c(34, 46, 51, 39, 22)
gender <- c("male", "female", "male", "male", "female")
educ   <- c(10, 12, 15, 13, 8)
wage_data <- data.frame(respid, hwage, age, gender, educ)

## -- Example 18
#

View(loenn_data3)

## -- Example 19
#

remove(age, gender, respid, hwage, educ)

## -- Example 20
#

wage_data <- data.frame(
  respid = c(1, 2, 3, 4, 5),
  hwage  = c(27.0, 33.0, 65.5, 44.5, 15.0),
  age    = c(34, 46, 51, 39, 22),
  gender = c("male", "female", "male", "male", "female"),
  educ   = c(10, 12, 15, 13, 8)
)

## -- Example 21
#

library(tibble)
wage_data <- tribble(
  ~respid, ~hwage, ~age, ~gender, ~educ,
        1,   27.0,   34,  "male",    10,
        2,   33.0,   46,"female",    12,
        3,   65.5,   51,  "male",    15,
        4,   44.5,   39,  "male",    13,
        5,   15.0,   22,"female",     8
)

## -- Example 22
#

save(wage_data, file="wage_data.Rdata")

## -- Example 23
#

load(file="wage_data.Rdata")

## -- Example 24
#

wage_data_nor <- wage_data
colnames(wage_data_nor) <- c("respnum", "tloenn", "alder",
                             "kjonn", "utdann")
wage_data_nor

## -- Example 25
#

mean(wage_data$age)

## -- Example 26
#

attach(wage_data)
mean(age)
detach("wage_data")

## -- Example 27
#

with(wage_data, mean(age))

## -- Example 28
#

with(wage_data, {
     print(age) 
      mean(age)
})

## -- Example 29
#

wage_data[,3]

## -- Example 30
#

wage_data[3,]

## -- Example 31
#

wage_data[,"age"]

## -- Example 32
#

height <- c(1.78, 1.67, 1.87, 1.99, 2.00)

## -- Example 33
#

class(height)

## -- Example 34
#

age <- c(78L, 67L, 87L, 99L, 100L)
class(age)   

## -- Example 35
#

as.integer(height)

## -- Example 36
#

gender <- c("male", "female", "male", "male", "female")                       

## -- Example 37
#

class(gender)

## -- Example 38
#

gender <- factor(gender, levels=c("female", "male", "other"))
gender

## -- Example 39
#

eductype <- c("Doctoral","Master","Bachelor",
              "Bachelor","HighSch")
eductype <- factor(eductype, ordered=TRUE,
   levels = c("Secondary","HighSch","Bachelor",
              "Master","Doctoral"))
eductype

## -- Example 40
#

pubpriv <- c(2,2,1,1,2)
pubpriv <- factor(pubpriv, levels=c(1,2),
           labels=c("public","private"))
pubpriv	

