#' Measurement model validity
#'
#' condisc assesses convergent and discriminant validity of latent constructs
#' expressed by congeneric (not loading on more than one factor) indicators making
#' up a confirmatory factor model estimated using sem.
#'
#' Convergent validity is the extent to which a set of indicators reflecting the same
#' construct are positively correlated. Convergent validity of a construct can be
#' claimed to be demonstrated when the construct can explain an average amount of 50
#' per cent variance of its indicators. This value is commonly referred to as average
#' variance extracted (AVE) in the litterature.
#'
#' AVE = Sum of squared standardised loadings/Number of indicators
#'
#' Discriminant validity can be exhibited when the average variance extracted (AVE)
#' value of a latent construct is larger than its squared correlation (SC) with any other
#' latent construct in the model, showing that each latent construct shares more variance
#' with its associated indicators than with any other latent variable expressed by
#' different sets of indicators in the model.
#'
#' When both convergent and discriminant validity are established, a latent construct
#' can be considered valid.
#'
#' condisc applies a strict criterion supporting discriminant validity only when
#' all of the AVE values are larger than all of the SC values.
#'
# library(psych)
# data(package="psych")
# bfi.comp <- bfi[complete.cases(bfi), ]
# dim(bfi.comp)
# bfi.comp2 <- bfi.comp[ ,1:25]
# head(bfi.comp2)
# library(lavaan)
# PERS.model <- '
# Agree =~ A1 + A2 + A3 + A4 + A5
# Consc =~ C1 + C2 + C3 + C4 + C5
# Extra =~ E1 + E2 + E3 + E4 + E5
# Neuro =~ N1 + N2 + N3 + N4 + N5
# Openn =~ O1 + O2 + O3 + O4 + O5
# '
#
# #@examples
# fit2 <- cfa(PERS.model, data=bfi.comp2)
# condisc(fit2)
#' @export
condisc <- function(x){
 std.loadings<- inspect(x, what="std")$lambda
 std.loadings[std.loadings==0] <- NA
 std.loadings <- std.loadings^2
 ave <- colMeans(std.loadings, na.rm=TRUE)
 #factor correlation matrix
 fcor <- lavInspect(x, "cor.lv")
 sqfcor <- fcor^2
 list(Squared_Factor_Correlation=round(sqfcor, digits=3),
      Average_Variance_Extracted=round(ave, digits=3))
}
