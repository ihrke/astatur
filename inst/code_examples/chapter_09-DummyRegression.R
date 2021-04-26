## chapter_09-DummyRegression.R
#
# This file contains all code examples from chapter 9 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(dplyr) 
flat2 <- mutate(flats,
                centre = if_else(location==1, 1, 0),
                south  = if_else(location==2, 1, 0),
                west   = if_else(location==3, 1, 0),
                east   = if_else(location==4, 1, 0)
                )

## -- Example 2
#

library(fastDummies) 
flat2 <- dummy_cols(flat2, select_columns="location")

## -- Example 3
#

model4 <- lm(flat_price ~ factor(location), data=flat2)

## -- Example 4
#

coef(model4)

## -- Example 5
#

flat2 <- mutate(flat2,
                centre = if_else(location==1, 1, 0))

## -- Example 6
#

model5 <- lm(flat_price ~ centre, data=flat2)

## -- Example 7
#

model6 <- lm(flat_price ~ factor(location==1), data=flat2)

## -- Example 8
#

summary(model6)

## -- Example 9
#

model7 <- lm(flat_price ~ centre + floor_size, data=flat2)

## -- Example 10
#

summary(model7)

## -- Example 11
#

xsvals3 <- data.frame(centre=c(0,1), 
                      floor_size=mean(flat2$floor_size))
predval3 <- predict(model7, newdata = xsvals3, 
                    interval = "confidence", level = 0.95)
xsvals_pval3 <- cbind(xsvals3, predval3)
xsvals_pval3

## -- Example 12
#

flat2 <- mutate(flat2, 
                location = factor(location,
                  levels = c(1, 2, 3, 4),
                  labels = c("centre", "south",
                             "west", "east")))

## -- Example 13
#

model8 <- lm(flat_price ~ location, data=flat2) 

## -- Example 14
#

summary(model8)

## -- Example 15
#

flat2$location <- relevel(flat2$location, ref="south")
model9 <- lm(flat_price ~ location, data = flat2)

## -- Example 16
#

flat2$location <- relevel(flat2$location, ref="west")
model10 <- lm(flat_price ~ location, data = flat2)

## -- Example 17
#

summary(model9)$coefficients

## -- Example 18
#

summary(model10)$coefficients

## -- Example 19
#

library(multcomp)
southVSwest <- glht(model8, linfct = 
         c("locationsouth - locationwest = 0"))
summary(southVSwest)

## -- Example 20
#

southVSeast <- glht(model8, linfct = 
          c("locationsouth - locationeast = 0"))
summary(southVSeast)

## -- Example 21
#

westVSeast <- glht(model8, linfct = 
           c("locationwest - locationeast = 0"))
summary(westVSeast)

## -- Example 22
#

flat2 <- 
  flat2 %>% 
  mutate(location = factor(location, 
    levels = c("centre", "south", "west", "east")))

## -- Example 23
#

flat2 %>% 
  group_by(location) %>% 
  summarise(mean(flat_price))

## -- Example 24
#

library(ggplot2) 
ggplot(flat2, aes(x=location, y=flat_price, colour=location)) +
    geom_boxplot() +
    stat_summary(fun.data=mean_cl_boot, geom="errorbar", 
                 colour="blue", width=0.1) +
    stat_summary(fun.y=mean, geom="point", colour="green") +
    geom_jitter(size=0.1)

## -- Example 25
#

library(sandwich) 
compTukey <- glht(model8, linfct=mcp(location="Tukey"),
                  vcov=sandwich)

## -- Example 26
#

summary(compTukey)

## -- Example 27
#

model11 <- lm(flat_price ~ location + floor_size, data=flat2) 

## -- Example 28
#

summary(model11)

## -- Example 29
#

xsvals4 <- data.frame(
  location=factor(c("centre","south","west","east"),  
                  levels=c("centre","south",
                           "west","east")), 
  floor_size=mean(flat2$floor_size))
predval4 <- predict(model11, newdata = xsvals4, 
                    interval = "confidence", level = 0.95)
xsvals_pval4 <- cbind(xsvals4, predval4)
xsvals_pval4

## -- Example 30
#

library(dplyr) # install the package if not installed!
flat2 <- mutate(flat2, 
                      energy_efficiency = 
                        factor(energy_efficiency,
                               levels = c(1, 2, 3),
                               labels = c("best", "mediocre",
                                          "poor")))

## -- Example 31
#

model12 <- lm(flat_price ~ location + energy_efficiency, 
              data=flat2)

## -- Example 32
#

summary(model12)

## -- Example 33
#

library(car) 
linearHypothesis(model12, c("locationsouth = 0", 
                            "locationwest = 0", 
                            "locationeast = 0"))

## -- Example 34
#

linearHypothesis(model12, c("energy_efficiencymediocre = 0", 
                            "energy_efficiencypoor = 0"))

