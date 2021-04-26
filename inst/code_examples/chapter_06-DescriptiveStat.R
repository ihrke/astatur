## chapter_06-DescriptiveStat.R
#
# This file contains all code examples from chapter 6 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(astatur)
data("olympic")

height <- filter(olympic, Sex=="F", !is.na(Height)) %>% 
  pull(Height)

## -- Example 2
#

sum(height)/length(height) # calculate the mean

## -- Example 3
#

mean(height)

## -- Example 4
#

ggplot(data.frame(height),aes(x=height)) + 
  geom_histogram(bins=15)+
  geom_vline(xintercept = mean(height), # calculate and show mean
             color="red") 

## -- Example 5
#

median(height)

## -- Example 6
#

height.with.outlier <- c(height, 160000)

## -- Example 7
#

mean(height.with.outlier) 
median(height.with.outlier) 

## -- Example 8
#

library(modeest)
mlv(height)

## -- Example 9
#

sum( ( height-mean(height) )^2 ) / (length(height)-1)

## -- Example 10
#

var(height)

## -- Example 11
#

sd(height)
sqrt(var(height))

## -- Example 12
#

quantile(height)

## -- Example 13
#

quantile(height, probs=c(0.05, 0.10, 0.9, 0.95))

## -- Example 14
#

range(height)
diff(range(height))

## -- Example 15
#

IQR(height)

## -- Example 16
#

library(moments)
ageatdeath <- deaths %>% uncount(deaths) %>% pull(age)
price <- flats %>% pull(flat_price)

tribble(
  ~dataset,    ~skewness,            ~kurtosis,
   "olympic",   skewness(height),     kurtosis(height),
   "deaths",    skewness(ageatdeath), kurtosis(ageatdeath),
   "flats",     skewness(price),      kurtosis(price)
)

## -- Example 17
#

mean(olympic$Sex)

## -- Example 18
#

table(olympic$Sex)

## -- Example 19
#

table(olympic$Medal, useNA="always")

## -- Example 20
#

olympic %>% 
  group_by(Medal) %>%
  summarise(num_athletes=n())

## -- Example 21
#

length( unique(olympic$Team) )

## -- Example 22
#

teams <- unique(olympic$Team)
tail(teams)

## -- Example 23
#

countries <- teams[!str_detect(teams, "-")]
length(countries)

## -- Example 24
#

olympic %>% 
  group_by(Team) %>%
  summarise(num_athletes=n()) %>% 
  arrange(desc(num_athletes)) %>%
  head(10)

## -- Example 25
#

summary(studentHeights)

## -- Example 26
#

library(summarytools)
descr(olympic)

## -- Example 27
#

freq(olympic$Medal)

## -- Example 28
#

dfSummary(studentHeights)

## -- Example 29
#

library(skimr)

olympic %>% skim(Team,Height,Weight)

## -- Example 30
#

olympic %>% group_by(Sex) %>% 
  skim(Team,Height,Weight) 

## -- Example 31
#

olympic %>% group_by(Sex) %>% 
  skim(Team,Height,Weight) %>%
  filter(skim_type=="numeric") 

## -- Example 32
#

myskim <- skim_with(numeric=sfl(skewness,kurtosis))
myskim(olympic, Age)

## -- Example 33
#

olympic.females <- olympic %>% filter(Sex=="F") %>% na.omit
height <- pull(olympic.females, Height)
weight <- pull(olympic.females, Weight)
cor(height,weight)

## -- Example 34
#

big.five <- epi.bfi %>% select(starts_with("bf"))
cor(big.five)

## -- Example 35
#

lowerCor(big.five)

## -- Example 36
#

olympic.females %>% select(where(is.numeric)) %>% lowerCor

## -- Example 37
#

table(studentHeights$gender, studentHeights$year)

## -- Example 38
#

olympic.ball <- olympic %>% 
  filter(Sport %in% c("Basketball", "Football", "Volleyball")) %>% 
  select(Sport,Medal,Sex)
table(olympic.ball)

## -- Example 39
#

library(summarytools)
ctable(studentHeights$gender,studentHeights$year)

## -- Example 40
#

olympic %>% 
  group_by(Sex) %>%  # group into male/female athletes
  filter(!is.na(Height)) %>%  # remove missing values
  summarise(mean=mean(Height),  # calculate mean
            median=median(Height),      # median etc.
            sd=sd(Height),
            skewness=skewness(Height),
            kurtosis=kurtosis(Height))


## -- Example 41
#

data("stroop")
str(stroop)

## -- Example 42
#

RT <- stroop %>% filter(subj=="120554") %>% pull(RT)
mean(RT)

## -- Example 43
#

mean.rt <- stroop %>% 
  group_by(subj) %>%
  summarise(mean.RT=mean(RT,na.rm=T)) 
str(mean.rt)

## -- Example 44
#

mean.rt %>%
  summarise(group.mean=mean(mean.RT),
            median=median(mean.RT),
            sd=sd(mean.RT),
            skewness=skewness(mean.RT),
            kurtosis=kurtosis(mean.RT))

## -- Example 45
#

mean.rt.cond <- stroop %>% 
  group_by(subj,condition) %>%
  summarise(mean.RT=mean(RT,na.rm=T)) 
head(mean.rt.cond)

## -- Example 46
#

mean.rt.cond %>%
  group_by(condition) %>%
  summarise(group.mean.RT=mean(mean.RT)) 

