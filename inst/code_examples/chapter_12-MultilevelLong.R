## chapter_12-MultilevelLong.R
#
# This file contains all code examples from chapter 12 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

head(diet)

## -- Example 2
#

depression.wide %>% 
  select(ID, starts_with("BDI")) %>% 
  head

## -- Example 3
#

depression.wide %>% 
  select(ID, starts_with("week")) %>% 
  head

## -- Example 4
#

depression %>% 
  select(ID, female,session, week, BDI) %>% head(10)

## -- Example 5
#

diet.long <- diet %>% 
  gather(pre.post, weight, pre.weight, post.weight)
head(diet.long)

## -- Example 6
#

diet.long %>% spread(pre.post, weight) 

## -- Example 7
#

depression.wide %>% 
  pivot_longer(cols=starts_with("week") | starts_with("BDI"),
               names_to = c(".value", "session"),
               names_pattern="(BDI|week)([0-9+])",
               values_drop_na=T) %>%
  head()

## -- Example 8
#

depression %>%
  gather(var,val, week,BDI) %>%
  pivot_wider(names_from=c("var","session"),
              values_from=c("val"),
              names_sep="") %>%
  head()

## -- Example 9
#

library(astatur)

show.IDs=sample(unique(depression$ID), 5)

depression %>%
  filter(ID %in% show.IDs) -> d.5subj

d.5subj %>%
  ggplot(aes(x=week,y=BDI,color=ID))+
  geom_point()+geom_line(aes(group=ID))

## -- Example 10
#

mod <- lm(BDI ~ week, data=d.5subj)
coef(mod)

## -- Example 11
#

d.5subj %>% nest(data=-ID) %>%
  mutate(coef.week = map(data, 
                    ~ coef(lm(BDI ~ week, data=.x))[2])) %>%
  unnest(coef.week) %>% select(ID,coef.week)

## -- Example 12
#

mod.id=lm(BDI ~ week + ID + week:ID, data=d.5subj)

## -- Example 13
#

library(emmeans)
emtrends(mod.id, "ID", var="week")

## -- Example 14
#

library(broom)
coefs.nopooling <- depression %>% nest(data=-ID) %>%
    mutate(model=map(data, ~ lm(BDI ~ week, data=.x)),
           tidied=map(model, tidy))  %>%
    unnest(tidied) %>%
    select(ID,coef=term, value=estimate) 

head(coefs.nopooling)

## -- Example 15
#

coefs.nopooling %>% 
  ggplot(aes(x=value))+
    geom_histogram()+
    facet_wrap(~coef, scales="free")

## -- Example 16
#

library(lme4)
mod <- lmer(BDI ~ week + (1+week|ID), data=depression)
summary(mod)

## -- Example 17
#

fixef(mod)
ranef(mod)

## -- Example 18
#

coef(mod)$ID %>%
  head()

## -- Example 19
#

ci.boot <- confint(mod, method="boot", nsim=1000)
ci.boot

## -- Example 20
#

ci.wald <- confint(mod, method="Wald")
ci.prof <- confint(mod, method="profile")

## -- Example 21
#

library(lmerTest)

## -- Example 22
#

find("lmer")

## -- Example 23
#

library(lme4)
find("lmer")

## -- Example 24
#

detach("package:lmerTest")

## -- Example 25
#

library(lmerTest)
mod=lmer(BDI ~ week + (1+week|ID), data=depression)
summary(mod)

## -- Example 26
#

summary(mod, ddf="Kenward-Roger")$coefficients

## -- Example 27
#

mod2<-lmer(BDI ~ week + female + age + married + (1+week|ID), 
           data=depression)
fixef(mod2)

## -- Example 28
#

anova(mod, mod2)

## -- Example 29
#

step(mod2, ddf="Kenward-Roger")

## -- Example 30
#

mod3 <- lmer(BDI ~ week+ female:week + female + age + (1+week|ID), 
             data=depression)
fixef(mod3)

## -- Example 31
#

anova(mod2,mod3)

## -- Example 32
#

mod0 <- lm  (BDI ~ week, depression)
mod1 <- lmer(BDI ~ week + (1|ID), depression)
mod2 <- lmer(BDI ~ week + (1+week|ID), depression)
anova(mod1,mod0,mod2)

## -- Example 33
#

library(performance)
icc(mod1)

## -- Example 34
#

mod.linear    <- lmer(BDI ~ poly(week,1)+(1+week|ID), depression)
mod.quadratic <- lmer(BDI ~ poly(week,2)+(1+week|ID), depression)
mod.cubic     <- lmer(BDI ~ poly(week,3)+(1+week|ID), depression)

## -- Example 35
#

anova(mod.linear,mod.quadratic, mod.cubic)

## -- Example 36
#

library(modelr)

show.IDs <- sample(levels(depression$ID), 30)
depression.ex <- depression %>% filter(ID %in% show.IDs)

expand_grid(ID=show.IDs, week=0:30) %>% 
  add_predictions(mod.linear, var = "linear") %>%
  add_predictions(mod.quadratic, var = "quadratic") %>%
  add_predictions(mod.cubic, var = "cubic") %>%
  gather(model,prediction, linear, quadratic,cubic) %>%
  ggplot(aes(week,prediction))+
    geom_point(aes(y=BDI), data=depression.ex)+
    geom_line(aes(y=BDI), data=depression.ex)+
    geom_line(aes(group=interaction(ID,model),color=model))+
    facet_wrap(~ID, ncol=10)


