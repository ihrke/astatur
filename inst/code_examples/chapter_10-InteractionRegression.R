## chapter_10-InteractionRegression.R
#
# This file contains all code examples from chapter 10 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(dplyr) 
library(astatur)
workout <- mutate(workout,
                  healthage = health * age)

## -- Example 2
#

lm(whours ~ health + age + healthage, data=workout)

## -- Example 3
#

lm(whours ~ health + age + health:age, data=workout)

## -- Example 4
#

lm(whours ~ health*age, data=workout)

## -- Example 5
#

model14 <- lm(whours ~ age*gender, data=workout)

## -- Example 6
#

summary(model14)

## -- Example 7
#

sim_slopes(model14, pred="age", modx="gender", 
           modx.values = c("female", "male"), 
           johnson_neyman=FALSE)

## -- Example 8
#

interact_plot(model14, pred="age", modx="gender", 
              modx.values = c("female", "male"),
              colors=c("red", "green"),  
              line.thickness=1.5, vary.lty=FALSE) + 
  theme_bw()

## -- Example 9
#

model13 <- lm(whours ~ health*age, data=workout)

## -- Example 10
#

summary(model13)

## -- Example 11
#

library(interactions)
sim_slopes(model13, pred="health", modx="age", 
           modx.values = c(16,26,36,46,56,66,76), 
           johnson_neyman=FALSE)

## -- Example 12
#

library(ggplot2)
interact_plot(model13, pred="health", modx="age", 
              modx.values = c(16,26,36,46,56,66,76), 
              colors=c("red", "green","violet", "blue", 
                       "orange", "turquoise", "gray"),  
              line.thickness=1.5, vary.lty=FALSE) + theme_bw()

## -- Example 13
#

workout <- workout %>% mutate(gender.num=as.integer(gender)-1)
model15 <- lm(whours ~ gender.num*marital, data=workout)

## -- Example 14
#

summary(model15)

## -- Example 15
#

sim_slopes(model15, pred="gender.num", modx="marital", 
           modx.values = c("married", "single"), 
           johnson_neyman=FALSE)

## -- Example 16
#

interact_plot(model15, pred="gender.num", modx="marital", 
              modx.values = c("married", "single"),
              colors=c("red", "green"),  
              line.thickness=1.5, vary.lty=FALSE) + 
  theme_bw()

## -- Example 17
#

model16 <- lm(whours ~ age*educ, data=workout)

## -- Example 18
#

summary(model16)

## -- Example 19
#

sim_slopes(model16, pred="age", modx="educ", 
           modx.values = c("secondary/high", "university",
                           "more.than.university"), 
           johnson_neyman=FALSE)

## -- Example 20
#

interact_plot(model16, pred="age", modx="educ", 
              modx.values = c("secondary/high", "university",
                              "more.than.university"),
              colors=c("red", "green", "blue"),  
              line.thickness=1.5, vary.lty=FALSE) + 
  theme_bw()

## -- Example 21
#

library(car) 
linearHypothesis(model16, c("age:educuniversity = 0", 
                            "age:educmore.than.university = 0"))

