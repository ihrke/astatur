#' Number of new students in Norway by year, age and gender
#'
#' A dataset containing the number of new students in Norway by year, age and gender for
#' the years 2000-2017. The data was downloaded from Det Statistiske Sentralbyraa (Statistics
#' Norway) https://www.ssb.no/.
#'
#'
#' @format A data frame with 504 rows and 4 variables:
#' \describe{
#'   \item{kjoenn}{Gender (one of "Menn"-male or "Kvinner"-female)}
#'   \item{alder}{agegroup, coded are <18, 19-29 and >30}
#'   \item{aar}{year}
#'   \item{studenter}{number of new students}
#' }
#' @source \url{https://www.ssb.no/}
"nyeStudenter"

#' Body-height in cm collected from a statistics course at a norwegian university
#' across three years.
#'
#' A dataset containing individual body heights along with a variable for gender and year
#' in which the data was collected.
#'
#'
#' @format A data frame with 99 rows and 3 variables:
#' \describe{
#'   \item{kjoenn}{Gender (one of "mann"-male or "kvinne"-female)}
#'   \item{aar}{year}
#'   \item{hoeyde}{body height in cm}
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
#' Datasettet inneholder informasjon om 95 leiligheter som var til salgs i foerste halvdel av 2013 i Trondheim.
#' Denne informasjonen omfatter pris, stoerrelse, beliggenhet, byggeaar og miljoemerking angaaende leilighetene.
#'
#'
#' @format A data frame with 95 rows and 6 variables:
#' \describe{
#'   \item{pris}{price in NOK}
#'   \item{pris2}{??}
#'   \item{beliggenhet}{location coded as 1,2,3 or 4 (1=centrum, 2=south, 3=west, 4=east)}
#'   \item{stoerrelse}{size of appartment (sqm)}
#'   \item{byggeaar}{year when built}
#'   \item{miljoemerking}{environmental score (1,2 or 3)}
#' }
#' @source
"leilighet"

#' Price of birthday presents.
#'
#' Datasettet inneholder 20 observasjoner og 4 variabler. Den foerste variabelen er `gave_verdi` som representerer
#' antall kroner en brukte paa en bursdagsgave til partneren sin sist. De andre to variablene heter `attraktiv`og
#' `snill` som henholdsvis maaler hvor attraktiv og snill en vurderer sin partner paa en skala 1 til 7.
#' Til slutt, har vi variabelen `alder` som viser respondentens alder.
#'
#'
#' @format A data frame with 20 rows and 4 variables:
#' \describe{
#'   \item{gave_verdi}{price in NOK}
#'   \item{attraktiv}{score for how attractive the partner was judged to be (1-7)}
#'   \item{snill}{score for how kind the partner was judged to be (1-7)}
#'   \item{alder}{age in years}
#' }
#' @source
"gave"

#' Number of deaths in Norway by age in single-year bins.
#'
#' A dataset containing the number of deaths in Norway in 2017 by year.
#' The data was downloaded from Det Statistiske Sentralbyraa (Statistics
#' Norway) https://www.ssb.no/.
#'
#'
#' @format A data frame with 106 rows and 2 variables:
#' \describe{
#'   \item{alder}{age numeric in years}
#'   \item{doede}{antall deaths in Norway in 2017}
#' }
#' @source \url{https://www.ssb.no/}
"doede"


#' Basic bio data on athletes and medal results from Summer Games in Rio 2016.
#'
#'
#'
#' @format A data frame with 13688 rows and 12 variables:
#' \describe{
#' \item{ID}{Unique number for each athlete}
#' \item{Name}{Athlete's name}
#' \item{Sex}{M or F}
#' \item{Age{Integer in years}
#' \item{Height}{In centimeters}
#' \item{Weight}{In kilograms}
#' \item{Team}{Team name}
#' \item{NOC}{National Olympic Committee 3-letter code}
#' \item{Games}{Year and season}
#' \item{Sport}{Sport}
#' \item{Event}{Event}
#' \item{Medal}{Gold, Silver, Bronze, or NA}
#' }
#' @source \url{https://www.kaggle.com/heesoo37/olympic-history-data-a-thorough-analysis/data}
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
"rnorsk.all.used.packages"

#' Data from a survey in a fitness center in Trondheim.
#'
#' @format A data frame with 210 rows and 6 variables:
#' @source
#' \describe{
#' \item{ttimer}{self-reported number of hours with training per week}
#' \item{kjoenn}{sex (0=female, 1=male)}
#' \item{alder}{age in years}
#' \item{utdann}{education (1=secondary/high, 2=university, 3=more than university)}
#' \item{sivsta}{civil status (0=married, 1=unmarried)}
#' \item{helse}{self-reported importance of health (0=Not important at all - 6=Very important)}
#' }
"trening"

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
"trening3"
