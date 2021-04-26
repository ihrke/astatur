## chapter_04-DataManagement.R
#
# This file contains all code examples from chapter 4 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(dplyr)

## -- Example 2
#

ChickWeight2 <- mutate(ChickWeight, log_weight = log(weight))

## -- Example 3
#

head(ChickWeight2)

## -- Example 4
#

ChickWeight2 <- mutate(ChickWeight2, 
                       int_time_weight = Time*weight)
head(ChickWeight2)

## -- Example 5
#

ChickWeight2 <- 
  mutate(ChickWeight2, 
         weight5 = case_when(weight <= 50 ~ 1,
                             weight > 50  & weight <= 100 ~ 2, 
                             weight > 100 & weight <= 150 ~ 3,
                             weight > 150 & weight <= 200 ~ 4,
                             TRUE ~ 5))

## -- Example 6
#

head(ChickWeight2, 15)

## -- Example 7
#

ChickWeight2 <- 
  mutate(ChickWeight2, 
         weight5_2 = 
           factor(weight5,
                  levels = c(1, 2, 3, 4, 5),
                  labels = c("very little", "little",
                             "medium", "big", "very big")))

## -- Example 8
#

ChickWeight2 <- mutate(ChickWeight2, 
                       weight = replace(weight, weight==42, 144))
head(ChickWeight2)

## -- Example 9
#

ChickWeight2 <- mutate(ChickWeight2, 
                       weight = replace(weight, weight==93, 555),
                       Time = replace(Time, Time==0, 30),
                       Diet = replace(Diet, Diet==1, 2))
head(ChickWeight2)

## -- Example 10
#

ChickWeight2 <- mutate(ChickWeight2, 
            weight = replace(weight, Time==8 & Diet==2, 2222))

## -- Example 11
#

head(ChickWeight2)

## -- Example 12
#

ChickWeight2 <- mutate(ChickWeight2, 
                       weight = replace(weight, weight < 60, NA),
                       Time = replace(Time, Time >= 10, NA))


## -- Example 13
#

head(ChickWeight2)

## -- Example 14
#

ChickWeight2 <- rename(ChickWeight2, Chick_number = Chick)
head(ChickWeight2)

## -- Example 15
#

ChickWeight2 <- rename(ChickWeight2, weight_gr = weight,
                                     days = Time,
                                     diet_rec = Diet)
head(ChickWeight2)

## -- Example 16
#

colSums(is.na(ChickWeight2))

## -- Example 17
#

which(is.na(ChickWeight2$weight_gr))

## -- Example 18
#

colSums(!is.na(ChickWeight2))

## -- Example 19
#

sum(complete.cases(ChickWeight2))

## -- Example 20
#

mean(ChickWeight2$weight_gr)

## -- Example 21
#

mean(ChickWeight2$weight_gr, na.rm=TRUE)

## -- Example 22
#

summary(ChickWeight2$weight_gr)

## -- Example 23
#

summary(lm(weight_gr ~ days, data=ChickWeight2))

## -- Example 24
#

na.omit(ChickWeight2)

## -- Example 25
#

ChickWeight2[complete.cases(ChickWeight2),] 

## -- Example 26
#

ChickWeight3 <- na.omit(ChickWeight2)
dim(ChickWeight3)

## -- Example 27
#

dummy <- model.matrix(~ ChickWeight2$diet_rec + 0) 

## -- Example 28
#

head(dummy)

## -- Example 29
#

Chickweight2 <- mutate(ChickWeight2, 
                       diet_rec1=if_else(diet_rec==1,  1, 0),
                       diet_rec2=if_else(diet_rec==2,  1, 0),
                       diet_rec3=if_else(diet_rec==3,  1, 0), 
                       diet_rec4=if_else(diet_rec==4,  1, 0))

## -- Example 30
#

ex_data <- data.frame(
  Age = c(28, 35, 45, 29, 43, 50, 32),
  NumSub = factor(c(5, 8, 9, 8, 12, 15, 9)),
  Degree = c("econ","psy","lit","lit","econ","soc","geog"))

## -- Example 31
#

str(ex_data)

## -- Example 32
#

ex_data <- mutate(ex_data,
                  Degree = as.factor(Degree))

## -- Example 33
#

ex_data <- mutate(ex_data,
                  NumSub = as.numeric(as.character(NumSub)))

## -- Example 34
#

as.numeric(c("hundred", "eleven", "ten", "10", "11.4"))

## -- Example 35
#

ex_data <- mutate(ex_data, 
                  Age = as.factor(Age))

## -- Example 36
#

ex_data <- mutate(ex_data,
                  Motivation = c(2, 5, 4, 2, 1, 5, 3))

## -- Example 37
#

library(Hmisc) 
label(ex_data$Motivation) <- 
  "1 = not motivated at all, 5 = very motivated" 

## -- Example 38
#

country <- factor(c("UK", "United Kingdom", "Holland", 
                    "Netherlands", "Holland", "UK", 
                    "United Kingdom"))

## -- Example 39
#

library(forcats) 
fct_recode(country, 
           Netherlands="Holland",
           `United Kingdom`="UK")

## -- Example 40
#

country <- factor(c("Dutch", "Wales", "Scotland", 
                    "Holland", "Netherlands", 
                    "United Kingdom", "England", 
                    "Northern Ireland"))

## -- Example 41
#

country <- fct_collapse(country,
             Netherlands = c("Dutch", "Holland", "Netherlands"),
             `United Kingdom` = c("Wales", "Scotland", 
                                  "United Kingdom", "England", 
                                  "Northern Ireland"))
country

## -- Example 42
#

names(msq)

## -- Example 43
#

personality <- select(msq, 
                      Extraversion, Neuroticism, 
                      Lie, Sociability, Impulsivity)

## -- Example 44
#

dim(personality)

## -- Example 45
#

personality2 <- select(msq, 
                       Extraversion:Impulsivity)
dim(personality2)

## -- Example 46
#

personality3 <- select(personality, 
                       -Lie, -Sociability)

## -- Example 47
#

names(personality3)

## -- Example 48
#

library(psych)
fembfi <- filter(bfi,
                 gender == 2)

## -- Example 49
#

dim(fembfi)

## -- Example 50
#

library(summarytools) 
freq(bfi$gender, report.nas = FALSE)

## -- Example 51
#

fem40high_bfi <- filter(bfi,
                        gender==2 & education==2 & age>40)

## -- Example 52
#

dim(fem40high_bfi)

## -- Example 53
#

dim(filter(bfi, age<20 | age>40))

## -- Example 54
#

  first50 <- slice(bfi, 
                     1:50)

## -- Example 55
#

dim(first50)

## -- Example 56
#

nonseqdata <- slice(bfi,
              c(5, 12, 27, 44, 66, 234, 555, 600, 734, 891))

## -- Example 57
#

dim(nonseqdata)

## -- Example 58
#

dataset1 <- data.frame(height = c(178, 193, 165, 185, 170),
                       age    = c(18, 23, 21, 35, 66))
dataset2 <- data.frame(gender = c("M", "M", "F", "M", "F"),
                       weight = c(92, 105, 57, 88, 60))

## -- Example 59
#

dataset3 <- bind_cols(dataset1, dataset2)
dataset3

## -- Example 60
#

dataset1 <- mutate(dataset1, ID=1:n())
dataset1

## -- Example 61
#

dataset2 <- mutate(dataset2, ID=n():1)
dataset2

## -- Example 62
#

full_join(dataset1, dataset2, by="ID")

## -- Example 63
#

data1 <- data.frame(workout.hours = c(2, 1, 0, 5, 8, 22),
                    age = c(66, 34, 39, 25, 27, 21))

data2 <- data.frame(workout.hours = c(5, 15, 3, 4, 7, 18),
                    age = c(22, 25, 50, 44, 33, 21))

## -- Example 64
#

data3 <- bind_rows(data1, data2)
data3

## -- Example 65
#

data_asc_height <- arrange(dataset3, height)
data_asc_height

## -- Example 66
#

arrange(dataset3, gender, weight)

## -- Example 67
#

wide_data <- data.frame(person = c(1, 2, 3, 4),
                        t1     = c(5, 3, 2, 6),
                        t2     = c(6, 4, 6, 5), 
                        t3     = c(6, 5, 6, 7), 
                        t4     = c(7, 6, 8, 9))
wide_data

## -- Example 68
#

library(tidyr) 
long_data <- gather(wide_data, time.point, stress.level, t1:t4)
head(long_data)

## -- Example 69
#

wide_data2 <- spread(long_data, time.point, stress.level)

## -- Example 70
#

all(wide_data2==wide_data)

## -- Example 71
#

names(bfi)

## -- Example 72
#

bfi_ord <- select(bfi, gender, education, age, everything())

## -- Example 73
#

names(bfi_ord)

## -- Example 74
#

bfi_ord2 <- select(bfi, starts_with("N"), everything())
names(bfi_ord2)

## -- Example 75
#

Orange_10 <- sample_n(Orange, 10)

## -- Example 76
#

dim(Orange_10)

## -- Example 77
#

Orange_40p <- sample_frac(Orange, 0.4)

## -- Example 78
#

dim(Orange_40p)

## -- Example 79
#

head(ChickWeight)

## -- Example 80
#

Diet1Chicks <- filter(ChickWeight, 
                      Diet == 1)

## -- Example 81
#

ChickWeight4 <- ChickWeight %>% 
                  filter(Diet == 1) %>% 
                  mutate(logweight = log(weight)) %>% 
                  select(logweight) %>% 
                  sample_n(5) 

## -- Example 82
#

ChickWeight4

