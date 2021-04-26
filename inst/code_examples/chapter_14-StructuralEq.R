## chapter_14-StructuralEq.R
#
# This file contains all code examples from chapter 14 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

inspect(est.meas.model, what="rsquare")

## -- Example 2
#

relicoef(est.meas.model)

## -- Example 3
#

condisc(est.meas.model)

## -- Example 4
#

saturated.mod <- '
  Collectiv  =~ 0*respected+0*secure
  Individual =~ 0*accomplish+0*self_fulfil+0*self_respect
#Covariance:
  respected ~~ secure
  respected ~~ accomplish
  respected ~~ self_fulfil
  respected ~~ self_respect
  secure ~~ accomplish
  secure ~~ self_fulfil
  secure ~~ self_respect
  accomplish ~~ self_fulfil
  accomplish ~~ self_respect
  self_fulfil ~~ self_respect
#Means
  respected ~ 1 
  secure ~ 1 
  accomplish ~ 1 
  self_fulfil ~ 1 
  self_respect ~ 1
    '
est.saturated.mod <- cfa(saturated.mod, data=values)
summary(est.saturated.mod, fit.measures=TRUE)

## -- Example 5
#

baseline.mod <- '
    Collectiv  =~ 0*respected+0*secure
    Individual =~ 0*accomplish+0*self_fulfil+0*self_respect
  #Means
    respected ~ 1 
    secure ~ 1 
    accomplish ~ 1 
    self_fulfil ~ 1 
    self_respect ~ 1
    '
est.baseline.mod <- cfa(baseline.mod, data=values)
summary(est.baseline.mod, fit.measures=TRUE)

## -- Example 6
#

modindices(est.meas.model, minimum.value=3.84)

## -- Example 7
#

meas.model2 <- '
              Collectiv  =~ respected+secure
              Individual =~ accomplish+self_fulfil+self_respect
              accomplish ~~ self_respect
              '
est.meas.model2 <- cfa(meas.model2, data=values)

## -- Example 8
#

summary(est.meas.model2, fit.measures=TRUE, estimates=FALSE)

## -- Example 9
#

meas.lpa.mod <- '
                Attractive =~ face + sexy
                Appearance =~ body + appear + attract
                Muscle =~ muscle + strength + endur
                Weight =~ lweight + calories + cweight
                '
est.meas.lpa.mod <- cfa(meas.lpa.mod, data=workout2)
summary(est.meas.lpa.mod, fit.measures=TRUE, standardized=TRUE)

## -- Example 10
#

meas.lpa.mod2 <- '
                Attractive =~ face + sexy
                Appearance =~ body + appear + attract
                Muscle =~ muscle + strength + endur
                Weight =~ lweight + calories + cweight
                muscle ~~ endur 
                lweight ~~ body
                '
est.meas.lpa.mod2 <- cfa(meas.lpa.mod2, data=workout2)
summary(est.meas.lpa.mod2, fit.measures=TRUE, standardized=TRUE)

## -- Example 11
#

condisc(est.meas.lpa.mod2)

## -- Example 12
#

relicoef(est.meas.lpa.mod2)

## -- Example 13
#

full.lpa.mod <- '
              #Measurement model (latent variables)
                Attractive =~ face + sexy
                Appearance =~ body + appear + attract
                Muscle =~ muscle + strength + endur
                Weight =~ lweight + calories + cweight
                muscle ~~ endur 
                lweight ~~ body
                Muscle ~~ 0*Weight #set covariance to 0
              #Structural model (regressions)
                Appearance ~ Attractive
                Muscle ~ Appearance
                Weight ~ Appearance
                '
est.full.lpa.mod <- sem(full.lpa.mod, data=workout2)
summary(est.full.lpa.mod, fit.measures=TRUE, standardized=TRUE)

## -- Example 14
#

inspect(est.full.lpa.mod, what="rsquare")

## -- Example 15
#

full.lpa.mod2 <- '
              #Measurement model (latent variables)
                Attractive =~ face + sexy
                Appearance =~ body + appear + attract
                Muscle =~ muscle + strength + endur
                Weight =~ lweight + calories + cweight
                muscle ~~ endur 
                lweight ~~ body
                Muscle ~~ 0*Weight #set covariance to 0
              #Structural model (regressions)
                Appearance ~ a*Attractive
                Muscle ~ b1*Appearance
                Weight ~ b2*Appearance
              #Indirect effects
                #of Attraction on Muscle
                ind1 := a*b1 
                #of Attraction on Weight
                ind2 := a*b2 
                '
est.full.lpa.mod2 <- sem(full.lpa.mod2, data=workout2)
summary(est.full.lpa.mod2, standardized=TRUE)

