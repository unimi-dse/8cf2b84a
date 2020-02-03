#' wb_plot: showing plots for World Bank data
#'
#' Displays a line plot for each indicator.
#' There are two possible usage:
#' \itemize{
#'     \item it is possible to use a local data frame, using it as parameter of \code{dataset};
#'     \item if ther argument \code{dataset} is missing, you must indicate the arguments \code{countries} and \code{indicators} and a dataset will be generated using \link{wb_tidy}
#' }
#'
#' @param countries Vector of strings. It must include the ISO Alpha-2 code of the countries of interest.
#' @param indicators Vector of strings. It must include the ID of the indicators from "The World Bank" datasets.
#' @param dataset Data frame. It is recommended to create one using \link{wb_tidy} in order to avoid possible errors.
#'
#' @author Sergio Picascia \email{sergio.picascia@studenti.unimi.it}
#'
#' @seealso \link{wb_tidy}
#'
#' @import WDI
#' @import tidyverse
#' @import farver
#'
#' @examples
#' wb_plot(countries = "IT", indicators = c("NY.GDP.MKTP.CD", "SP.DYN.LE00.IN"))
#'
#' \dontrun{
#' wb_plot(dataset = my_data)
#' }
#'
#' @export
wb_plot <- function(countries, indicators, dataset) {

 # Creating the dataset
 if (missing(dataset)) {
  dataset <- wb_tidy(countries, indicators)
 }

 index <- 4
 col_vect <- names(dataset)

 # For each column that represent an indicator...
 for (i in dataset[, -c(1, 2, 3)]) {

  # ...show the line plot
  show(dataset %>%
        ggplot(aes(.[[3]], .[[index]], col = .[[1]])) +
        geom_line() +
        labs(x = col_vect[3], y = col_vect[index], colour = col_vect[2]))
  index <- index + 1
 }
}
