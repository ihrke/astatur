## chapter_15-BayesianStats.R
#
# This file contains all code examples from chapter 15 in 
# Mehmetoglu & Mittner (2021). Applied Statistics Using R. SAGE.
##

## setup
library(tidyverse)
library(astatur)
theme_set(theme_astatur())

## -- Example 1
#

library(brms)
flats2 <- mutate(flats, price=flat_price/1000,
                 size=floor_size-mean(floor_size))
mod=brm(price ~  size, data=flats2)

## -- Example 2
#

mod <- brm(price ~  size, data=flats2, 
           iter=5000, chains=8)

## -- Example 3
#

rhat(mod)

## -- Example 4
#

neff_ratio(mod)

## -- Example 5
#

library(bayesplot)
mcmc_trace(mod)

## -- Example 6
#

summary(mod)

## -- Example 7
#

mod.lm <- lm(price ~ size, data=flats2)
lm.coef <- coef(mod.lm) 
brms.coef <- fixef(mod)[,1]
names(lm.coef) <- names(brms.coef) # use same names for display
bind_rows(lm=lm.coef,brm=brms.coef, 
          abs.diff=abs(lm.coef-brms.coef),.id="method") %>% 
  column_to_rownames("method")-> tab
tab %>% round(digits=1)

## -- Example 8
#

bayes_R2(mod)

## -- Example 9
#

mod.mat <- as.data.frame(mod)
colnames(mod.mat)
dim(mod.mat)

## -- Example 10
#

mod.mat %>% select(-lp__) %>%
  gather(variable, sample) %>%
  ggplot(aes(x=sample))+
    geom_histogram()+
    facet_wrap(~ variable, scales="free")

## -- Example 11
#

library(bayesplot)
params=c("b_Intercept", "b_size", "sigma")

mcmc_intervals(mod.mat, pars=params)
mcmc_hist(mod.mat, pars=params)
mcmc_areas(mod.mat, pars=params)
mcmc_dens(mod.mat, pars=params)
mcmc_violin(mod.mat, pars=params)
mcmc_pairs(as.array(mod), pars=params)

## -- Example 12
#

in.interval <- with(mod.mat, b_size>4 & b_size<6)
mean(in.interval)

## -- Example 13
#

hypothesis(mod, "size>0")

## -- Example 14
#

mod2 <- brm(price ~ size + location, data=flats2)
summary(mod2)

## -- Example 15
#

hypothesis(mod2, c("locationsouth<0",
                   "locationwest<0",
                   "locationeast<0",
                   "locationsouth<locationwest",
                   "locationsouth<locationeast",
                   "locationwest<locationeast"))

## -- Example 16
#

bayes_R2(mod,  summary=F)

## -- Example 17
#

mod1.R2 <- as.vector(bayes_R2(mod,  summary=F))
mod2.R2 <- as.vector(bayes_R2(mod2, summary=F))
mod.R2 <- data.frame(mod1.R2, mod2.R2)
mcmc_areas(mod.R2)

## -- Example 18
#

hypothesis(mod.R2, "mod2.R2>mod1.R2")

## -- Example 19
#

loo1 <- loo(mod)
loo2 <- loo(mod2)
loo_compare(loo1,loo2)

## -- Example 20
#

model_weights(mod,mod2)

## -- Example 21
#

mod1.all <- update(mod,  iter=20000, chains=4, save_all_pars=T)
mod2.all <- update(mod2, iter=20000, chains=4, save_all_pars=T)

## -- Example 22
#

bayes_factor(mod2.all,mod1.all)

## -- Example 23
#

library(BayesFactor)
bf1 <- lmBF(price ~ size, data=flats2)
bf2 <- lmBF(price ~ size + location, data=flats2)
bf2/bf1

## -- Example 24
#

ppred.mod1 <- posterior_predict(mod, nsamples=100)
price.real <- as.vector(flats2$price)

## -- Example 25
#

ppc_dens_overlay(price.real, ppred.mod1)
ppc_intervals(price.real, ppred.mod1)

## -- Example 26
#

mod3 <- brm(price ~  size, 
            data=flats2, family=lognormal())

## -- Example 27
#

ppred.mod3 <- posterior_predict(mod3, nsamples=100)
ppc_dens_overlay(price.real, ppred.mod3)

## -- Example 28
#

loo1 <- loo(mod)
loo3 <- loo(mod3)
loo_compare(loo1,loo3)

## -- Example 29
#

prior_summary(mod)

## -- Example 30
#

mod.1 <- update(mod, 
                prior=c(set_prior("normal(0,5)", class="b")), 
                sample_prior=T)
mod.2 <- update(mod, 
                prior=c(set_prior("normal(0,10)", class="b")), 
                sample_prior=T)
mod.3 <- update(mod, 
                prior=c(set_prior("normal(0,100)", class="b")), 
                sample_prior=T)

## -- Example 31
#

data.frame(
  mod.1=fixef(mod.1)["size",],
  mod.2=fixef(mod.2)["size",],
  mod.3=fixef(mod.3)["size",]
)

## -- Example 32
#

mod.4 <- update(mod, 
                prior=c(set_prior("normal(0,0.5)", class="b")), 
                sample_prior=T)

## -- Example 33
#

fixef(mod.4)["size",]

## -- Example 34
#

plot(hypothesis(mod.4, "size>0"))

