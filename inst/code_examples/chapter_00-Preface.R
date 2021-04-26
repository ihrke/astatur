## chapter_00-Preface.R
#
# This file contains all code examples from chapter 0 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

install.packages("devtools")
devtools::install_github("ihrke/astatur")

## -- Example 2
#

library(astatur)

## -- Example 3
#

flats

## -- Example 4
#

data(package="astatur")

## -- Example 5
#

install.packages(astatur.all.used.packages)

## -- Example 6
#

lsf.str("package:astatur")

