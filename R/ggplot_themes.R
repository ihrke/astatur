#' Theme that looks a bit like SPSS.
#'
#' Credits to Matti Vuorre:
#' https://twitter.com/vuorre/status/700867902463868928
#' https://gist.githubusercontent.com/mvuorre/bb1e3e412cfa88590f97/raw/a2fe56c2b1d07ebde29af0cf7cd071dc329840c5/theme_spss.R
#'
#' @export
#' @param base_family Font family used
#' @return A ggplot-theme that can be added to ggplot-objects.
#'
theme_spss <- function(base_family = "Helvetica") {
  ggplot2::theme(text = ggplot2::element_text(family = base_family, face = "bold"),
        axis.ticks = ggplot2::element_line(colour = "black", size = 1),
        panel.background = ggplot2::element_rect(colour = "black",
                                        fill = "gray90", size = 1.5),
        panel.grid = ggplot2::element_blank(),
        aspect.ratio = 1)
}

#' Theme used for "Applied Statistics using R".
#'
#'
#' @export
#' @return A ggplot-theme that can be added to ggplot-objects.
#'
theme_astatur <- function(...){
  ggplot2::theme_bw(...)
}
