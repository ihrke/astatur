## chapter_11-LogisticRegression.R
#
# This file contains all code examples from chapter 11 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

prob    <- seq(0,1,by=0.001)
logodds <- log(prob/(1-prob))

## -- Example 2
#

library(astatur)
data(titanic)
table(titanic$Survived)

## -- Example 3
#

mod <- glm(Survived ~ Age, family=binomial(link="logit"), 
           data=titanic)

## -- Example 4
#

summary(mod)

## -- Example 5
#

confint(mod)

## -- Example 6
#

coefs <- coef(mod)
coefs

## -- Example 7
#

plogis(coefs)

## -- Example 8
#

p.60y <- plogis(coefs["(Intercept)"] + 60*coefs["Age"])
p.70y <- plogis(coefs["(Intercept)"] + 70*coefs["Age"])
p.70y - p.60y

## -- Example 9
#

predict(mod, newdata=data.frame(Age=c(60,70)), type="response")

## -- Example 10
#

p.2030y <- predict(mod, newdata=data.frame(Age=c(20,30)), 
                   type="response")
diff(p.2030y)

## -- Example 11
#

library(visreg)
visreg(mod)
visreg(mod, scale="response")

## -- Example 12
#

exp(coef(mod))

## -- Example 13
#

diff.logodds=diff(predict(mod, newdata=
      tibble(Age=c(60,70)), type="link"))
(1-exp(diff.logodds))*100

## -- Example 14
#

library(lmtest)
lrtest(mod)

## -- Example 15
#

library(DescTools)
PseudoR2(mod, which="all")

## -- Example 16
#

mod2 <- glm(Survived ~ Sex+Age, 
            family=binomial(link='logit'), 
            data=titanic)
summary(mod2)

## -- Example 17
#

lrtest(mod, mod2)

## -- Example 18
#

rbind(
 age.only      =PseudoR2(mod,  which=c("Nagelkerke","CoxSnell")), 
 age.and.gender=PseudoR2(mod2, which=c("Nagelkerke","CoxSnell"))
) %>% round(digits = 2)

## -- Example 19
#

predict(mod2, newdata = 
          tibble(Age=20,
                 Sex=c("female","male")), 
        type="response") 

## -- Example 20
#

exp(coef(mod2))

## -- Example 21
#

(1-exp(coef(mod2)["Sexmale"]))*100

## -- Example 22
#

visreg(mod2, scale ="response")

## -- Example 23
#

mod3 <- glm(Survived ~ Sex+Age+Sex:Age, 
            family=binomial(link='logit'), 
            data=titanic)

## -- Example 24
#

lrtest(mod,mod2,mod3)

pR2.methods=c("Nagelkerke", "CoxSnell")
rbind(
  age.only          = PseudoR2(mod, which = pR2.methods), 
  age.and.gender    = PseudoR2(mod2, which = pR2.methods),
  age.and.gender.ia = PseudoR2(mod3, which = pR2.methods))

## -- Example 25
#

summary(mod3)$coefficients %>% round(digits = 3)

## -- Example 26
#

visreg(mod3, xvar = "Age", by="Sex",scale="response")

## -- Example 27
#

table(titanic$Pclass)

## -- Example 28
#

class(titanic$Pclass)

## -- Example 29
#

mod4 <- glm(Survived ~ Sex*Age + Pclass, 
            family=binomial(link='logit'),
            data=titanic)

## -- Example 30
#

lrtest(mod3,mod4)

rbind(
  age.and.gender.ia        = PseudoR2(mod3, which = "Nagelkerke"),
  age.and.gender.ia.pclass = PseudoR2(mod4, which = "Nagelkerke"))

## -- Example 31
#

summary(mod4)$coefficients

## -- Example 32
#

d <- expand.grid(Age=seq(0,80),
                 Sex=c("female","male"),
                 Pclass=c(1,2,3))

## -- Example 33
#

library(modelr)
dpred <- d %>% add_predictions(model=mod4, type="response")

## -- Example 34
#

ggplot(dpred, aes(x=Age,y=pred,color=Sex))+
  geom_line()+
  facet_wrap( ~ Pclass)

## -- Example 35
#

mod5 <- glm(Survived ~ Sex*Age * Pclass, 
            family=binomial(link='logit'), 
            data=titanic)

## -- Example 36
#

lrtest(mod4, mod5)
rbind(
  age.gender.pclass    = PseudoR2(mod4, which = "Nagelkerke"),
  age.gender.pclass.ia = PseudoR2(mod5, which = "Nagelkerke"))

## -- Example 37
#

dpred2 <- d %>% 
  add_predictions(var = "mod4", model=mod4, type="response") %>%
  add_predictions(var = "mod5", model=mod5, type="response")

## -- Example 38
#

dpred2 %>% 
  gather(model, pred, mod4, mod5) %>%
  ggplot(aes(x=Age,y=pred,color=model))+
    geom_line()+facet_grid(Sex ~ Pclass)


## -- Example 39
#

titanic.complete <- na.omit(titanic, cols=c("Survived", "Age", 
                                            "Sex", "Pclass"))

## -- Example 40
#

ntotal <- nrow(titanic.complete)
ntrain <- floor(0.75*ntotal)
ntest  <- ntotal-ntrain

## -- Example 41
#

train.ix <- sample.int(n=ntotal, size = ntrain, replace = F)

## -- Example 42
#

titanic.train <- titanic.complete[ train.ix,]
titanic.test  <- titanic.complete[-train.ix,]

## -- Example 43
#

mod.train <- glm(Survived ~ Sex*Age * Pclass, 
                 family=binomial(link='logit'), 
                 data=titanic.train)

## -- Example 44
#

titanic.test.pred <- add_predictions(data = titanic.test, 
                                     model= mod.train,
                                     var  = "pred.probability",  
                                     type = "response")

## -- Example 45
#

titanic.test.pred <- titanic.test.pred %>% 
  mutate(pred.Survived = 
           case_when(pred.probability>0.5 ~ 1,
                                        T ~ 0))

## -- Example 46
#

with(titanic.test.pred, 
     table(Survived, pred.Survived))

## -- Example 47
#

library(caret)
predicted <- factor(titanic.test.pred$pred.Survived, 
                    labels=c("died", "survived"))
survived  <- factor(titanic.test.pred$Survived,      
                    labels=c("died", "survived"))
confusionMatrix(predicted, survived)

## -- Example 48
#

library(plotROC)
 
ggplot(titanic.test.pred, aes(d=Survived, m=pred.probability))+
  geom_roc()

## -- Example 49
#

p <- ggplot(titanic.test.pred, aes(d=Survived, 
                                   m=pred.probability))+
  geom_roc()
calc_auc(p)[["AUC"]]

## -- Example 50
#

library(broom)
library(modelr)
library(purrr)

titanic.complete %>% crossv_kfold(k=10) %>%   
  mutate(mod=map(train, ~ glm(Survived ~ Sex*Age * Pclass, 
                              family=binomial(link='logit'), 
                              data=.))) %>%
  mutate(predicted = map2(mod, test, 
                          ~ augment(.x, newdata = .y, 
                                    type.predict="response"))) %>%
  mutate(perc.correct=map(predicted, function(df) { 
    df %>% mutate(pred=.fitted>0.5, 
                  correct=(Survived==pred)) %>% 
      pull(correct) %>% sum(na.rm=T)/(dim(df)[1]) 
    })) %>% unnest(perc.correct) %>% pull(perc.correct) -> 
  perc.correct
perc.correct

## -- Example 51
#

summary(perc.correct)

