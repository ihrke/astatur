## chapter_13-FactorAnalysis.R
#
# This file contains all code examples from chapter 13 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(dplyr)
workout3_comp <- filter(workout3,
                        complete.cases(workout3))

## -- Example 2
#

library(psych)
paranalysis <- fa.parallel(workout3_comp, 
      fm="pa", fa="fa", SMC="TRUE")

## -- Example 3
#

print(paranalysis)

## -- Example 4
#

squaredmc <- smc(workout3_comp)
squaredmc
mean(squaredmc)

## -- Example 5
#

fmodel1 <- fa(workout3_comp,
              nfactors = 2, 
              fm="pa",
              rotate = "varimax")

## -- Example 6
#

print(fmodel1$n.obs)

## -- Example 7
#

print(fmodel1$loadings, digits=4, cutoff=0)

## -- Example 8
#

comm <- fmodel1$communality
comm
sum(comm)

## -- Example 9
#

cbind(h2=fmodel1$communality, u2=fmodel1$uniquenesses) 

## -- Example 10
#

itemlist <- list(relaxation=c("Var1","Var2","Var3"),
                 appearance=c("Var4","Var5","Var6"))
summateds <- scoreItems(itemlist, workout3_comp, 
                         min=1, max=6, totals = FALSE)
factordata <- as.data.frame(summateds$scores)

## -- Example 11
#

workout3_comp <- bind_cols(workout3_comp, factordata)
names(workout3_comp)

## -- Example 12
#

relaxation <- data.frame(workout3_comp[,1:3])
alpha(relaxation)$total$std.alpha

## -- Example 13
#

appearance <- data.frame(workout3_comp[,4:6])
alpha(appearance)$total$std.alpha

