#' Predictor relative importance
#'
#' This function visually displays the importance of predictors in a regression model
#' based on the magnitude of the completely standardised coefficients.
#'
#' @examples
#' mymodel <- lm(qsec ~ disp + mpg + hp + wt, data=mtcars)
#' vimp(mymodel)
#'
#' @export

vimp <- function(regmod){
 modeldata <- model.frame(regmod)
 scaleddata <- as.data.frame(scale(modeldata))
 formulam <- formula(regmod)
 regmodstd <- lm(formulam,data=scaleddata)
 coeftable <- round(summary(regmodstd)$coefficients[-1,1], digits=3)
 coefdataf <- as.data.frame(coeftable)
 coefdataf$predictor <- rownames(coefdataf)
 rownames(coefdataf) <- NULL
 colnames(coefdataf) <- c("std.coefs", "predictor")
 library(ggplot2)
 ggplot(coefdataf, aes(x=predictor, y=abs(std.coefs), fill=predictor)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=std.coefs), vjust=0) +
  geom_hline(yintercept=c(0.1,0.2,0)) +
  scale_y_continuous(breaks = seq(0,1,by=0.1)) +
  geom_hline(aes(yintercept= 0.1, linetype = "<0.1, small effect"), colour= 'red') +
  geom_hline(aes(yintercept= 0.2, linetype = ">0.2, large effect"), colour= 'blue') +
  scale_linetype_manual(name = "limit", values = c(1,1),
                        guide = guide_legend(override.aes = list(color = c("red", "blue"))))
}
