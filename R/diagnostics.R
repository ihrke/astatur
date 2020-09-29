#' Regression diagnostics.
#'
#' 1) The assumption of homoskedasticity is examined using the Breusch-Pagan test
#' (Gujarati, 2012, pp. 86-87). Since the Ho:homoskedastic residuals, p-value < 0.05
#' would show that there is a heterokedasticity problem in the model.
#'
#' 2) The assumption of no severe multicollinearity is examined using VIF (Variance
#' Inflation Factor)-values. A VIF value above 5.0 is used as a sign of severe
#' multicollinearity in the model (Studenmund, 2006, p.271).
#'
#' 3) The assumption of normally-distributed residuals is examined using Shapiro-Wilk
#' W test. Since the Ho:residuals are normmally distributed, p-value < 0.01 would
#' indicate that residuals are not normally distributed. The reason why I propose
#' 0.01 as a cutoff is that in almost every case, we reject the Ho at 0.05. Further,
#' Shapiro-Wilk W test is, like any other, sensitive to large sample sizes. I still
#' suggest that one additionnaly examines the residual plots.
#'
#' 4) The assumption of correctly specified model is examined using the linktest (Stata
#' Manual, pp. 1041-1044). A statistically significant _hatsq (p < 0.05) would show a
#' specification problem.
#'
#' 5) The assumption of appropriate functional form is examined using Ramsey's regression
#' specification error test (RESET) (Wooldridge, pp. 303-305). Since the Ho: appropriate
#' functional form, p-value < 0.05 would indicate a functional form problem.
#'
#' 6) Influence is based on both leverage and the extent to which the observation is
#' an outlier. Cook's distance (D) is used to locate any influential observations. An
#' observation with D > 1 would often be considered  an influential case and should thus be
#' removed from the analysis (Pardoe, 2006, p. 171).
#'
#' @export
#' @param model lm-model object
#' @return tibble
#' @examples
#' mod=lm(Sepal.Length ~ Sepal.Width * Petal.Length, data=iris)
#' regression.diagnostics(mod)
#'
#' cars1 <- cars[1:30, ]  # original data
#' cars_outliers <- data.frame(speed=c(19,19), dist=c(190, 1806))  # introduce outliers.
#' cars2 <- rbind(cars1, cars_outliers)  # data with outliers.
#' mod=lm(speed ~ dist, data=cars2)
#' regression.diagnostics(mod)
regression.diagnostics <-
  function(mod,
           crit.bp = 0.05,
           crit.ncv = 0.05,
           crit.vif = 5.00,
           crit.shapiro = 0.01,
           crit.reset = 0.05,
           crit.linktest = 0.05,
           crit.cook = 1.00,
           crit.outlier = 0.05,
           crit.dwt = 0.05) {
    if(!is.element(class(mod), "lm")){
      stop("need 'lm' object")
    }
    bp.obj = lmtest::bptest(mod)
    bp.res = with(
      bp.obj,
      list(
        assumption = "heteroskedasticity",
        variable = "global",
        test = method,
        label = "bp",
        statistic = statistic,
        p.value = p.value,
        crit = crit.bp,
        problem = (p.value < crit.bp)
      )
    )

    ncv.obj = car::ncvTest(mod)
    ncv.res = with(
      ncv.obj,
      list(
        assumption = "heteroskedasticity",
        variable = "global",
        test = test,
        label = "ncv",
        statistic = ChiSquare,
        p.value = p,
        crit = crit.ncv,
        problem = (p < crit.bp)
      )
    )

    if (length(coef(mod)) > 2) {
      vif.obj = car::vif(mod)
      vif.res = tibble::tibble(
        assumption = "multicollinearity",
        variable = names(vif.obj),
        test = "Variance Inflation Factor",
        label = "vif",
        statistic = vif.obj,
        p.value = NA,
        crit = crit.vif,
        problem = (statistic > crit.vif)
      )
    } else {
      # VIF not defined for models with only one variable
      vif.obj = NULL
      vif.res = list(
        assumption = "multicollinearity",
        test = "Variance Inflation Factor",
        label = "vif",
        problem = F
      )
    }

    shapiro.obj = shapiro.test(residuals(mod))
    shapiro.res = with(
      shapiro.obj,
      list(
        assumption = "normality",
        variable = "global",
        test = method,
        label = "shapiro",
        statistic = statistic,
        p.value = p.value,
        crit = crit.shapiro,
        problem = (p.value < crit.shapiro)
      )
    )

    linktest.obj = linkTest(mod)
    linktest.res = with(
      linktest.obj,
      list(
        assumption = "model specification",
        variable = "global",
        test = "Stata Link-test",
        label = "linktest",
        statistic = coefficients["predicted_sq"],
        p.value = (p <- summary(linktest.obj)$coefficients[3, 4]),
        crit = crit.linktest,
        problem = (p < crit.linktest)
      )
    )

    reset.obj = lmtest::resettest(mod)
    reset.res = with(
      reset.obj,
      list(
        assumption = "functional form",
        variable = "global",
        test = method,
        label = "reset",
        statistic = statistic,
        p.value = p.value,
        crit = crit.reset,
        problem = (p.value < crit.reset)
      )
    )
    cook.obj = cooks.distance(mod)
    cook.res = list(
      assumption = "outliers",
      variable = "global",
      test = "Cook's distance",
      label = "cook",
      statistic = max(cook.obj),
      p.value = NA,
      crit = crit.cook,
      problem = (max(cook.obj) > crit.cook)
    )



    outlier.obj = car::outlierTest(mod, cutoff = crit.outlier)
    outlier.res = list(
      assumption = "outliers",
      variable = "global",
      test = "Bonferroni Outlier Test (car::outlierTest)",
      label = "outlier",
      statistic = max(abs(outlier.obj$rstudent)),
      p.value = min(outlier.obj$bonf.p),
      crit = crit.outlier,
      problem = (min(outlier.obj$bonf.p) < crit.outlier)
    )

    # Test for Autocorrelated Errors
    durbin.obj = car::durbinWatsonTest(mod)
    durbin.res = with(
      durbin.obj,
      list(
        assumption = "autocorrelation",
        variable = "global",
        test = "Durbin-Watson Test for Autocorrelated Errors",
        label = "durbin",
        statistic = r,
        p.value = p,
        crit = crit.dwt,
        problem = (p < crit.dwt)
      )
    )

    res = list(
      diagnostic.table = dplyr::bind_rows(
        bp.res,
        ncv.res,
        vif.res,
        shapiro.res,
        linktest.res,
        reset.res,
        cook.res,
        outlier.res,
        durbin.res
      ),
      test.objs = list(
        bp = bp.obj,
        ncv = ncv.obj,
        vif = vif.obj,
        shapiro = shapiro.obj,
        linktest = linktest.obj,
        reset = reset.obj,
        cook = cook.obj,
        outlier = outlier.obj,
        durbin = durbin.obj
      )
    )
    class(res) <- "regression.diagnostics"
    return(res)
  }

as.data.frame.regression.diagnostics <- function(x) {
  return(as.data.frame(x$diagnostic.table))
}

#'
#' @export
print.regression.diagnostics <- function(res) {
  good = crayon::combine_styles("green", "bold")
  ok = crayon::combine_styles("orange", "bold")
  problem = crayon::combine_styles("red", "bold")
  header = crayon::combine_styles("cyan", "underline")

  `%>%` <- magrittr::`%>%`
  if (is.installed("emo")) {
    decision.label = function(sig) {
      ifelse(sig, emo::ji("-1"), emo::ji("+1"))
    }
  } else {
    decision.label = function(sig) {
      ifelse(sig, "-", "+")
    }
  }
  tab = res$diagnostic.table

  cat("Tests of linear model assumptions\n")
  cat("---------------------------------\n\n")
  perc.failed = (sum(tab$problem) / dim(tab)[1]) * 100
  if (perc.failed < 1) {
    style = good
  } else if (perc.failed < 30) {
    style = ok
  } else {
    style = problem
  }
  cat(sprintf(
    style("%i/%i (%.1f %%) checks failed\n\n"),
    sum(tab$problem),
    dim(tab)[1],
    perc.failed
  ))
  cat("\n")
  cat(header("Identified problems: "))
  if (perc.failed == 0) {
    cat(good("NONE\n"))
  } else {
    problems = unique(tab$assumption[tab$problem])
    cat("\n")
    cat(problem(paste(
      sprintf("\t%s", problems),
      sep = "\n",
      collapse = "\n"
    )))
    cat("\n")
  }
  cat(header("Summary:\n"))
  res$diagnostic.table %>%
    dplyr::select(-label) %>%
    dplyr::mutate(
      decision = decision.label(problem),
      problem = ifelse(problem, "Problem", "No Problem")
    ) -> tab.summary

  print(tab.summary, n = 1000)

  cat("\nOutliers:\n")
  cat("-----------\n")
  cook.ix = which(tab$label == "cook")
  cat(header(sprintf(
    "Cook's distance (criterion=%.2f):", tab[cook.ix, "crit"]
  )))
  if (!tab$problem[cook.ix]) {
    cat(good(" No outliers\n"))
  } else {
    s = sort(res$test.objs[["cook"]])
    outliers = s[s > tab$crit[cook.ix]]
    cat("\n")
    print(data.frame(index = names(outliers), cooksd = outliers), row.names = F)
  }
  outlier.ix = which(tab$label == "outlier")
  cat(header(sprintf("Outlier test (criterion=%.2f):", tab[outlier.ix, "crit"])))
  if (!tab$problem[outlier.ix]) {
    cat(good(" No outliers\n"))
  } else {
    cat("\n")
    print(res$test.objs[["outlier"]])
  }
}

########################################################################
# Keith Chamberlain
# www.ChamberlainStatistics.com
# Created: 08Jul18
# Last updated: 28Jul18
##
# 000 - 08Jul18 - Initial function definition
# 001 - 09Jul18 - Added code so that model does not have to be in
#                 the .GlobalEnv environment for the function to work.
# 002 - 28Jul18 - Fixed bug that the variables in the formula do not
#                 match the coefficient names. Got rid of need to rename
#                 the coefficients. Added check that variance isn't zero
#                 to perform test.
##
# This code is released under GNU 3.0 and may be used for any purpose.
########################################################################
# linkTest() determines whether a model in R is 'well specified' using
# the Stata 'link test'. If the model is 'well specified', the squared
# term should not be significant. Currenly, only lm(), glm() and
# gamlss() models have been (minimally) tested.
##
linkTest <- function(model) {
  # Define variables for predicted values using names not likely to
  # conflict with other names in the environment of model
  predicted <- predict(model)
  predicted_sq <- predicted ^ 2
  # Check to see that the predicted and predicted^2 variable actually
  # vary.
  if (round(var(predicted), digits = 2) == 0) {
    stop("No parameters that vary. Cannot perform test.")
  }
  # The variables need to be found in the environment of model for
  # the update() call to work.
  dat=data.frame(dv=model.frame(model)[,1],
                 predicted,
                 predicted_sq)
  model = lm(dv ~ predicted + predicted_sq, data=dat)
  model
}
