library(semPlot) #draws SEM models
library(lavaan) #estimates SEM models
library(simstandard)
library(stringr)
library(rtf)

#' Save output from SEM model to an RTF file
#'
#'
#' @export
#' @return
#' @examples
#' # simstandard's sim_standardized() simulates population model-based
#' # standardised data whereas lavaan's simulateData() simulates
#' # population model-based unstandardised data. But, both
#' # sim_standardized() and simulateData() do a good job
#'
#' # Here we are now setting the parameters as we think would
#' # be in the population.
#' model01a <- '
#'            F1 =~ 0.77*var1 + 0.82*var2 + 0.91*var3
#'            F2 =~ 0.74*var4 + 0.87*var5 + 0.78*var6
#'            '
#' # Based on model01a we simulate data using sim_standardized()
#' df1 <- sim_standardized(model01a, n=100000)
#'
#' # Now that we have simulated the data, let us see if we are
#' # getting the same numbers after estimating the model below
#' model01b <- '
#'         Factor1 =~ var1 + var2 + var3
#'         Factor2 =~ var4 + var5 + var6
#'         '
#' model01b.est <- lavaan::cfa(model01b, data=df1)
#'
#' aa<-semtoword(model01b.est)
#' aa
#' rtowfile <- RTF("mysem.doc")
#' datatb <- aa
#' addTable(rtowfile, as.data.frame(datatb))
#' done(rtowfile)
#'
semtoword <- function (mod){
  latvarname <- lavNames(mod, type = "lv")
  obsvarname <- lavNames(mod, type = "ov")
  parest <- parameterestimates(model01b.est, standardized=TRUE)
  idest <- parest$lhs %in% latvarname & !parest$rhs %in% latvarname
  Std.Loadings <- parest[idest, c("rhs","std.all")]
  colnames(Std.Loadings) <- c("Observed", "Loading")
  Std.Loadings$Loading <- round(Std.Loadings$Loading, digits = 3)
  idest2 <- parest$lhs %in% latvarname & !parest$rhs %in% latvarname
  sumlambdasq <- with(parest[idest2, ], tapply(est, lhs, sum)^2)
  AVE <- round(sumlambdasq/length(parest$rhs), digits = 3)
  idest3 <- parest$lhs %in% latvarname & (parest$lhs == parest$rhs)
  factorvar <- with(parest[idest3, ], tapply(est, lhs, sum))

  lla <- list()
  llb = list()
  llc = list()
  for (lvar in latvarname) {
    ixa <- parest$lhs == lvar & parest$rhs %in% obsvarname
    #lvars = parest[ix, "lhs"]
    lla[[lvar]] <- parest[ixa, "lhs"]
    ix = parest$lhs == lvar & parest$rhs %in% obsvarname
    ovars = parest[ix, "rhs"]
    ix = parest$lhs %in% ovars & parest$rhs == parest$lhs
    llb[[lvar]] = sum(parest[ix, ]$est)
    ix = parest$lhs %in% ovars & parest$rhs %in% ovars &
      parest$lhs != parest$rhs
    llc[[lvar]] = sum(parest[ix, ]$est)
    }
  lvnames <- unlist(lla)
  Latent <- as.character(lvnames)
  keepix <- as.logical(c(1,diff(as.numeric(str_sub(Latent, -1)))))
  Latent[!keepix] <- ""
  errvar = unlist(llb)
  corrErr = unlist(llc)
  RRC = round((sumlambdasq * factorvar)/(sumlambdasq * factorvar +
                                     errvar + 2 * corrErr), digits = 3)
  df <- data.frame(Latent, Std.Loadings, RRC="", AVE="")
  df$RRC[keepix] <- RRC
  df$AVE[keepix] <- AVE

  return(df)
}



