## chapter_01-IntroR.R
#
# This file contains all code examples from chapter 1 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

help.search("factor analysis")

## -- Example 2
#

??"factor analysis"

## -- Example 3
#

help(anova)

## -- Example 4
#

install.packages("haven")

## -- Example 5
#

library(haven)

## -- Example 6
#

remove.packages("haven")

## -- Example 7
#

detach("package:haven", unload=TRUE)

## -- Example 8
#

packages <- installed.packages()
namesofpackages <- rownames(packages)
save(namesofpackages, file="mypackages.Rdata")

## -- Example 9
#

load("mypackages.Rdata")
install.packages(namespackages)

## -- Example 10
#

update.packages()

