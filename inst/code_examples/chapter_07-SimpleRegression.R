## chapter_07-SimpleRegression.R
#
# This file contains all code examples from chapter 7 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(astatur)
model1 <- lm(flat_price ~ floor_size, flats)

## -- Example 2
#

summary(model1)

## -- Example 3
#

library(ggplot2) 
ggplot(flats, aes(x=floor_size, y=flat_price)) + 
  geom_point(size=3) + 
  geom_smooth(method=lm, se=FALSE) +
  geom_hline(yintercept=mean(flats$flat_price), color="red") +
  theme_bw()+labs(x="floor size (sqm)", y="flat price (USD)")

## -- Example 4
#

confint(model1)

## -- Example 5
#

values <- data.frame(floor_size=seq(60, 220, by=20))
predict(model1, values, interval="confidence")


