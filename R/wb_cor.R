#' wb_cor: computing correlations for World Bank data
#'
#' Prints a matrix which values are the correlations between the chosen indicators for each of the selected countries.
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
#' wb_cor(countries = c("US", "CN", "RU"), indicators = c("SP.POP.TOTL", "SL.TLF.TOTL.IN", "NY.GDP.PCAP.CD"))
#'
#' \dontrun{
#' wb_cor(dataset = my_data)
#' }
#'
#' @export
wb_cor <- function(countries, indicators, dataset) {

 # Creating the dataset
 if (missing(dataset)) {
  dataset <- wb_tidy(countries, indicators)
 }

 # For every country in the dataset...
 for (c in levels(dataset$`ISO-2`)) {

  # ...filter for country and compute correlations between indicators
  country_data <- dataset %>% filter(.[[1]] == c)
  print(c)
  print(cor(country_data[, -c(1, 2, 3)], use = "complete.obs"))
 }
}
