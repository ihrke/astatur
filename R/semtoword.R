library(semPlot) #draws SEM models
library(lavaan) #estimates SEM models
library(simstandard)
#simstandard's sim_standardized() simulates population model-based
#standardised data whereas lavaan's simulateData() simulates
#population model-based unstandardised data. But, both
#sim_standardized() and simulateData() do a good job

#Here we are now setting the parameters as we think would
#be in the population.
model01a <- '
           F1 =~ 0.77*var1 + 0.82*var2 + 0.91*var3
           F2 =~ 0.74*var4 + 0.87*var5 + 0.78*var6
           F3 =~ 0.70*var7 + 0.80*var8 + 0.90*var9
           F4 =~ 0.69*var10 + 0.76*var11 + 0.83*var12
           '
#Based on model01a we simulate data using sim_standardized()
df1 <- sim_standardized(model01a, n=100000)
dim(df1)
head(df1) #generates standardized data confimed by the
#command below as it show 0 mean 1 std
sapply(df1, function(x) c(avg = mean(x), std = sd(x)))
#Now that we have simulated the data, let us see if we are
#getting the same numbers after estimating the model below
model01b <- '
           Factor1 =~ var1 + var2 + var3
           Factor2 =~ var4 + var5 + var6
           Factor3 =~ var7 + var8 + var9
           Factor4 =~ var10 + var11 + var12
           Factor1 ~ Factor2 + Factor3
           Factor4 ~ Factor1 + Factor2 + Factor3 
           '
model01b.est <- sem(model01b, data=df1)


#mod=model01b.est
semtoword <- function (model01b.est){
  library(semTools)
  library(rtf)
  library(stringr)
  #extracts the latent variables of the estimated model
  latvarname <- lavNames(model01b.est, type = "lv")
  latvarname 
  #extracts the observed variables of the estimated model
  obsvarname <- lavNames(model01b.est, type = "ov")
  obsvarname
  #extracts the unstandardised and standardised estimates in a data 
  #frame to easily extract what we want to do the needed computations
  parest <- parameterestimates(model01b.est, standardized=TRUE)
  parest
  #creates an index based on the following condition to
  #extract only the loadings of the indicators on factors  
  #excluding the rest of the data frame named parest
  idest <- parest$lhs %in% latvarname & !parest$rhs %in% latvarname
  idest
  #using this idest, we get the standardised loadings in a data frame
  Std.Loadings <- parest[idest, c("rhs","std.all")]
  Std.Loadings
  #we change the names of this data frame that will go into df 
  #further down below that will out into Word
  colnames(Std.Loadings) <- c("Observed", "Loading")
  Std.Loadings
  #we constraint the digits to 3 and show 0s in case rounded at lower
  Std.Loadings$Loading <- format(round(Std.Loadings$Loading, digits = 3), nsmall = 2)
  Std.Loadings
  #using the index idest from above to sum the unstandardised coefficients
  sumlambdasq <- with(parest[idest, ], tapply(est, lhs, sum)^2)
  sumlambdasq
  #using the same index, idest, we compute average variance extracted 
  AVE <- format(round(with(parest[idest, ], 
         tapply(std.all^2, lhs, mean)), digits = 3), nsmall = 2)
  AVE
  #creates a new index based on a different condition below
  #to compute factor variances
  idest2 <- parest$lhs %in% latvarname & (parest$lhs == parest$rhs)
  idest2
  factorvar <- with(parest[idest2, ], tapply(est, lhs, sum))
  factorvar
  #now we will create another index to do some more calculations
  #this new index requires conditions done in a for-loop
  
  #first, we create four empty lists to later fill in with the 
  #computations we get in the loop 
  lla <- list()
  llb <- list()
  llc <- list()
  lld <- list()
  for (lvar in latvarname) {
    #creates an index, ixa, based on a condition
    #based on this condition we are getting the
    #name of each latent variable for each set of indicators
    ixa <- parest$lhs == lvar & parest$rhs %in% obsvarname
    ixa
    lvariables <- parest[ixa, "lhs"]
    lvariables
    lla[[lvar]] <- parest[ixa, "lhs"]
    #using the same index, we are getting the set of
    #indicators for each latent variables
    ovars <- parest[ixa, "rhs"]
    ovars
    #creates a new index based on a new condition to get to 
    #the error variances in the parest data frame
    ixb <- parest$lhs %in% ovars & parest$rhs == parest$lhs
    ixb
    llb[[lvar]] <- sum(parest[ixb, ]$est)
    #creates a new index based on a new condition to get to 
    #the correlated error variances in the parest data frame    
    ixc <- parest$lhs %in% ovars & parest$rhs %in% ovars &
           parest$lhs != parest$rhs
    llc[[lvar]] <- sum(parest[ixc, ]$est)
    }
    lla # each latent
    llb # each set of indicators
    llc # error variances
    lld # correlated error variances
  #we are unlisting all these lists to use for further 
  #manipulation below
  #latent variables unlisted
  lvnames <- unlist(lla)
  Latent <- as.character(lvnames)
  #error variance unlisted
  errvar = unlist(llb)
  #correlated error variance unlisted
  corrErr = unlist(llc)
  #now we can calculate RRC by using numbers from the unlisted objects
  RRC = format(round((sumlambdasq * factorvar)/
                     (sumlambdasq * factorvar + errvar + 2 * corrErr)
                     , digits = 3), nsmall = 2)
  df <- data.frame(Latent, Std.Loadings, RRC, AVE)
  #When we run df now, the factors, RRC and AVE are repeating as it
  #is a data frame.Below, we create an index to avoid this repetion
  #and apply this index as below.
  keepix <- as.logical(c(1,diff(as.numeric(str_sub(Latent, -1)))))
  Latent[!keepix] <- "" #empties latent by applying keepix
  df2 <- data.frame(Latent, Std.Loadings, RRC="", AVE="")
  df2$RRC[keepix] <- RRC #adds RRC to df2 after applying keepix
  df2$AVE[keepix] <- AVE #adds AVE to df2 after applying keepix
  measurement.model <- df2
  #return(measurement.model)
  
  idest3 <- parest$op == "~"
  idest3
  beta <- data.frame(parest[idest3, c("lhs","rhs","est","se","pvalue")])  
  keepix <- as.logical(c(1,diff(as.numeric(str_sub(beta$lhs, -1)))))
  beta$lhs[!keepix] <- "" #empties latent by applying keepix
  roundests <- format(round(beta[,c("est","se","pvalue")], digits = 3), nsmall=2)
  beta <- cbind(beta[,c("lhs","rhs")], roundests)
  colnames(beta) <- c("DepVar","IndepVar","Coef","SE","p-value")
  structural.model <- beta
  #return(structural.model)
  
  
  std.loadings <- inspect(model01b.est, what = "std")$lambda
  std.loadings[std.loadings == 0] <- NA
  std.loadings <- std.loadings^2
  ave <- colMeans(std.loadings, na.rm = TRUE)
  fcor <- lavInspect(model01b.est, "cor.lv")
  sqfcor <- fcor^2
  discvalid <- list(Squared_Factor_Correlation = round(sqfcor, digits = 3), 
       Average_Variance_Extracted = round(ave, digits = 3))
  
  visualised.model <- semPaths(model01b.est)
  #return(visualised.model)
  
  full.sem <- list(Measurement=measurement.model, 
                   Structural=structural.model,
                   Discriminant.Validity=discvalid,
                   Research.Model=visualised.model)  
  return(full.sem)
  for(i in 1:length(full.sem)){
    write.csv(data.frame(full.sem[[i]]), 
              file = paste0("C:/MyR/my_r_working_directory", names(full.sem)[i], '.csv'))
                  }
  }

output <- semtoword(model01b.est)
output

# rtowfile <- RTF("mysem.doc")
# datatb <- aa$measurement.model
# addTable(rtowfile, as.data.frame(datatb))
# done(rtowfile)













