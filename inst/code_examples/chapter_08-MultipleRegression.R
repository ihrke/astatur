## chapter_08-MultipleRegression.R
#
# This file contains all code examples from chapter 8 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(astatur)
model2 <- lm(Present_Value ~ Attractiveness + Kindness + Age, 
             data=present)

## -- Example 2
#

summary(model2)

## -- Example 3
#

confint(model2)

## -- Example 4
#

library(lm.beta) 
lm.beta(model2)

## -- Example 5
#

vimp(model2)

## -- Example 6
#

present_z <- data.frame(scale(present))
model3 <- lm(Present_Value ~ Attractiveness + Kindness + Age, 
             data= present_z)
summary(model3)

## -- Example 7
#

confint(model3)

## -- Example 8
#

library(multcomp) 
comp1 <- glht(model3, linfct=c("Attractiveness - Kindness = 0"))
summary(comp1)
comp2 <- glht(model3, linfct=c("Attractiveness - Age = 0"))
summary(comp2)
comp3 <- glht(model3, linfct=c("Kindness - Age = 0"))
summary(comp3)

## -- Example 9
#

library(relaimpo) 
calc.relimp(model2, type="last")

## -- Example 10
#

xsvals <- data.frame(Attractiveness=7, Kindness=7, Age=50)
predval <- predict(model2, newdata = xsvals, 
                   interval = "confidence", level = 0.95)
xsvals_pval <- cbind(xsvals, predval)
xsvals_pval

## -- Example 11
#

xsvals2 <- data.frame(Attractiveness=c(1,2,3,4,5,6,7), 
                      Kindness=mean(present$Kindness), 
                      Age=mean(present$Age)) 
predval2 <- predict(model2, newdata = xsvals2, 
                    interval = "confidence", level = 0.95)
xsvals_pval2 <- cbind(xsvals2, predval2)
xsvals_pval2

## -- Example 12
#

library(ggplot2) 
ggplot(xsvals_pval2, aes(x=Attractiveness, y=fit)) +
  geom_smooth(aes(ymin = lwr, ymax = upr), 
              stat = "identity") 

## -- Example 13
#

library(stargazer)
stargazer(model2, ci=TRUE, type="text", 
          keep.stat=c("n", "rsq"),
          out="model2.txt")

## -- Example 14
#

plot(model2)

## -- Example 15
#

library(performance)
check_model(model2)

## -- Example 16
#

regression.diagnostics(model2) 

## -- Example 17
#

present2 <- present %>% 
  add_row(Present_Value=20000, Attractiveness=1, 
          Kindness=7, Age=100)
model2b <- lm(Present_Value ~ Attractiveness + Kindness + Age, 
              data=present2)
regression.diagnostics(model2b)

