#' Number of new students in Norway by year, age and gender
#'
#' A dataset containing the number of new students in Norway by year, age and gender for
#' the years 2000-2017. The data was downloaded from Det Statistiske Sentralbyraa (Statistics
#' Norway) https://www.ssb.no/.
#'
#'
#' @format A data frame with 504 rows and 4 variables:
#' \describe{
#'   \item{gender}{Gender (one of "male" or "female")}
#'   \item{age}{agegroup, coded as <18, 19-29 and >30}
#'   \item{year}{year}
#'   \item{students}{number of new students}
#' }
#' @source \url{https://www.ssb.no/}
"newStudents"

#' Body-height in cm collected from a statistics course at a Norwegian university
#' across three years.
#'
#' A dataset containing individual body heights along with a variable for gender and year
#' in which the data was collected.
#'
#'
#' @format A data frame with 99 rows and 3 variables:
#' \describe{
#'   \item{gender}{Gender (one of male or female)}
#'   \item{year}{year}
#'   \item{height}{body height in cm}
#' }
"studentHeights"

#' Single-trial responses from a Stroop task (85 subjs).
#'
#' A dataset containing individual responses (RT/accuracy) from
#' 85 individuals completing a standard Stroop-task.
#' Raw data and description available at https://osf.io/kxpqu/.
#'
#'
#' @format A data frame with 49309 rows and 9 variables:
#' \describe{
#'   \item{subj}{subject ID}
#'   \item{trial}{trial number in experiment}
#'   \item{color}{color of the presented word}
#'   \item{condition}{one of "neutral" (the presented word was XXXXX), "congruent" (the meaning of the presented
#'   word was identical to the color of the word) and "incongruent" (the meaning of the word was a different color than the
#'   print color of the stimulus)}
#'   \item{correct}{whether the response was correct}
#'   \item{response}{the color indicated by the participant (by button press)}
#'   \item{RT}{reaction time (in sec) between presentation of the stimulus and the response}
#'   \item{age}{participants age at time of data-acquisition}
#'   \item{female}{indicator variable (1=female, 0=male)}
#' }
#' @source \url{https://osf.io/kxpqu/}
"stroop"

#' Prices of apartments in 2013, Trondheim, Norway.
#'
#' The dataset contains information about 95 apartments that were sold in the first part of 2013 in Trondheim, Norway.
#'
#'
#'
#' @format A data frame with 95 rows and 6 variables:
#' \describe{
#'   \item{flat_price}{price in USD}
#'   \item{location}{location coded as 1,2,3 or 4 (1=centrum, 2=south, 3=west, 4=east)}
#'   \item{floor_size}{size of appartment (sqm)}
#'   \item{year_built}{year when built}
#'   \item{energy_efficiency}{environmental score (1,2 or 3)}
#' }
#'
"flats"


#' Price of birthday presents.
#'
#' The dataset comprises 20 observations of 4 variables describing the value of
#' birthday presents respondents offered their partners for their latest birthday.
#'
#'
#' @format A data frame with 20 rows and 4 variables:
#' \describe{
#'   \item{Present_Value}{price in NOK}
#'   \item{Attractiveness}{score for how attractive the partner was judged to be (1-7)}
#'   \item{Kindness}{score for how kind the partner was judged to be (1-7)}
#'   \item{Age}{age in years}
#' }
#'
"present"

#' Number of deaths in Norway by age in single-year bins.
#'
#' A dataset containing the number of deaths in Norway in 2017 by year.
#' The data was downloaded from Det Statistiske Sentralbyraa (Statistics
#' Norway) https://www.ssb.no/.
#'
#'
#' @format A data frame with 106 rows and 2 variables:
#' \describe{
#'   \item{age}{age numeric in years}
#'   \item{deaths}{number of deaths in Norway in 2017}
#' }
#' @source \url{https://www.ssb.no/}
"deaths"


#' Basic bio data on athletes and medal results from Summer Games in Rio 2016.
#'
#'
#'
#' @format A data frame with 13688 rows and 12 variables:
#' \describe{
#' \item{ID}{Unique number for each athlete}
#' \item{Name}{Athlete's name}
#' \item{Sex}{M or F}
#' \item{Age}{Integer in years}
#' \item{Height}{In centimeters}
#' \item{Weight}{In kilograms}
#' \item{Team}{Team name}
#' \item{NOC}{National Olympic Committee 3-letter code}
#' \item{Games}{Year and season}
#' \item{Sport}{Sport}
#' \item{Event}{Event}
#' \item{Medal}{Gold, Silver, Bronze, or NA}
#' }
#'
#'
#' @source \url{https://www.kaggle.com/heesoo37/olympic-history-data-a-thorough-analysis/data}
#'
#' @examples
#' plot(dplyr::sample_frac(olympic, 0.05))
#' summary(olympic)
#'
"olympic"



#' Titanic Passenger Survival Data Set.
#' This dataset has been re-packaged for convenience from
#' https://github.com/paulhendricks/titanic
#'
#'
#' @format A data frame with 1309 rows and 12 variables:
#' @source https://www.kaggle.com/c/titanic/data
#' \describe{
#' \item{PassengerId}{Passenger ID}
#' \item{Survived}{Passenger Survival Indicator}
#' \item{Pclass}{Passenger Class}
#' \item{Name}{Name}
#' \item{Sex}{Sex}
#' \item{Age}{Age}
#' \item{SibSp}{Number of Siblings/Spouses Aboard}
#' \item{Parch}{Number of Parents/Children Aboard}
#' \item{Ticket}{Ticket Number}
#' \item{Fare}{Passenger Fare}
#' \item{Cabin}{Cabin}
#' \item{Embarked}{Port of Embarkation}
#' }
"titanic"

#' List of all R-packages that are used in the book.
#'
#'
#' @format A character vector
#' \describe{
#' }
"astatur.all.used.packages"

#' Data from a survey in a fitness center in Trondheim.
#'
#' @format A data frame with 210 rows and 6 variables:
#' @source
#' \describe{
#' \item{whours}{self-reported number of hours with training per week}
#' \item{gender}{sex (0=female, 1=male)}
#' \item{age}{age in years}
#' \item{educ}{education (1=secondary/high, 2=university, 3=more than university)}
#' \item{marital}{marital status (0=married, 1=unmarried)}
#' \item{health}{self-reported importance of health (0=Not important at all - 6=Very important)}
#' }
"workout"

#' Data from a survey in a fitness center in Trondheim.
#' Questions were of the form "How important is it to workout ..."
#'
#' @format A data frame with 246 rows and 11 variables:
#' @source
#' \describe{
#' \item{lweight}{to loose weight (1=not important at all - 6=very important)}
#' \item{calories}{to burn calories (1=not important at all - 6=very important)}
#' \item{cweight}{to control my weight (1=not important at all - 6=very important)}
#' \item{body}{to have a good body (1=not important at all - 6=very important)}
#' \item{appear}{to improve my appearance (1=not important at all - 6=very important)}
#' \item{attract}{to look more attractive (1=not important at all - 6=very important)}
#' \item{muscle}{to develop my muscles (1=not important at all - 6=very important)}
#' \item{strength}{to get stronger (1=not important at all - 6=very important)}
#' \item{endur}{to increase my endurance (1=not important at all - 6=very important)}
#' \item{face}{How well does the following describe you as a person -  attractive face (1=not important at all - 6=very important)}
#' \item{sexy}{How well does the following describe you as a person - sexy (1=not important at all - 6=very important)}
#'
"workout2"

#' Data from 6 Questions from a survey in a fitness center in Trondheim (2014).
#' Questions were of the form "I am training ..."
#'
#' @format A data frame with 246 rows and 6 variables:
#' @source
#' \describe{
#' \item{Var1}{to help manage stress (1=not important at all - 6=very important)}
#' \item{Var2}{to release tension (1=not important at all - 6=very important)}
#' \item{Var3}{to mentally relax (1=not important at all - 6=very important)}
#' \item{Var4}{to have a good body (1=not important at all - 6=very important)}
#' \item{Var5}{to improve my appearance (1=not important at all - 6=very important)}
#' \item{Var6}{to look more attractive (1=not important at all - 6=very important)}
#' }
"workout3"


#' Data from a web-based intervention study for depression.
#'
#' Høifødt, R. S., Mittner, M., Lillevoll, K., Katla, S. K., Kolstrup, N.,
#' Eisemann, M., & Friborg, O. (2015). Predictors of response to Web-based
#' cognitive behavioral therapy with high-intensity face-to-face therapist
#' guidance for depression: a Bayesian analysis. Journal of medical
#' Internet research, 17(9), e197.
#'
#' @format A data frame with 554 rows and 10 variables:
#' @source
#' \describe{
#' \item{ID}{ID for individual patients}
#' \item{female}{0=male, 1=female}
#' \item{age}{in years}
#' \item{married}{0=not married, 1=married}
#' \item{job}{0=does not have job, 1=has job}
#' \item{AUDIT}{Alcohol Use Disorders Identification Test}
#' \item{motivation}{self-reported motivation to complete the web-based therapy (0-100)}
#' \item{session}{session number}
#' \item{week}{in which week from start of study the session took place}
#' \item{BDI}{Becks depression inventory}
#' }
"depression"

#' Data from a web-based intervention study for depression converted into
#' wide-format from the dataset `depression`.
#'
#' @format A data frame with 554 rows and 10 variables:
#' @source
#' \describe{
#' \item{ID}{ID for individual patients}
#' \item{female}{0=male, 1=female}
#' \item{age}{in years}
#' \item{married}{0=not married, 1=married}
#' \item{job}{0=does not have job, 1=has job}
#' \item{AUDIT}{Alcohol Use Disorders Identification Test}
#' \item{motivation}{self-reported motivation to complete the web-based therapy (0-100)}
#' \item{week1}{in which week from start of study the session took place}
#' \item{week2}{in which week from start of study the session took place and so on}
#' \item{BDI1}{Becks depression inventory in session 1}
#' \item{BDI2}{BDI in session 2 (and so on)}
#' }
"depression.wide"


#' Contains information on persons undergoing one of three different kinds of diets.
#' https://www.sheffield.ac.uk/polopoly_fs/1.536445!/file/MASH_ANOVA_in_R.pdf
#'
#' @format A data frame with 76 rows and 6 variables:
#' @source
#' \describe{
#' \item{person}{ID for individual participants}
#' \item{gender}{0=female, 1=male}
#' \item{age}{in years}
#' \item{diet}{diet 1-3}
#' \item{pre.weight}{bodyweight before the diet}
#' \item{post.weight}{bodyweight after the diet}
#' }
"diet"

#' The data was obtained from a survey of 1004 Norwegian
#' individuals. In this survey, the respondents were asked
#' to indicate (on an ordinal scale from 1 = not at all
#' important, to 5 = very important) how important each
#' of five personal values was as a guiding
#' principle in their lives.
#'
#'
#' @format A data frame with 1004 rows and 5 variables:
#' @source
#' \describe{
#' \item{respected}{being well respected by others}
#' \item{secure}{having a sense of security}
#' \item{accomplish}{having a sense of accomplishment}
#' \item{self_fulfil}{self-fulfillment}
#' \item{self_respect}{self-respect}
#' }
"values"
