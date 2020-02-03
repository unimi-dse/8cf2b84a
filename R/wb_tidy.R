#' wb_tidy: tidy World Bank dataset
#'
#' Returns a data frame of the chosen indicators for the selected countries.
#'
#' @param countries Vector of strings. It must include the ISO Alpha-2 code of the countries of interest.
#' @param indicators Vector of strings. It must include the ID of the indicators from "The World Bank" datasets.
#'
#' @author Sergio Picascia \email{sergio.picascia@studenti.unimi.it}
#'
#' @seealso \link[WDI]{WDIsearch}, for indicators' ID.
#'
#' @import WDI
#' @import tidyverse
#' @import farver
#'
#' @return This function returns a \code{data.frame} including columns:
#' \itemize{
#'     \item ISO-2
#'     \item Country
#'     \item Year
#'     \item \code{indicators}
#' }
#'
#' @examples
#' wb_tidy(countries = "IT", indicators = "NY.GDP.MKTP.CD")
#'
#' wb_tidy(countries = c("US", "CN", "RU"), indicators = c("SP.POP.TOTL", "SL.TLF.TOTL.IN", "NY.GDP.PCAP.CD"))
#'
#' @export
wb_tidy <- function(countries, indicators) {

 # Creating the dataset
 dataset <- as_tibble(WDI(country = countries, indicator = indicators))

 # Putting Year column first in case of one indicator
 if (length(indicators) == 1) {
  dataset <- dataset[, c(1, 2, 4, 3)]
 }

 col_vect <- c("ISO-2", "Country", "Year")

 # Extract indicators' names
 for (i in indicators) {
  search_result <- WDIsearch(string = i, field = "indicator")
  if (length(search_result) == 2) {
   y <- search_result["name"]
   col_vect <- append(col_vect, y)
  } else {
   x <- data.frame(search_result, stringsAsFactors = F)
   y <- (x %>% filter(indicator == i))$name
   col_vect <- append(col_vect, y)
  }
 }

 # Assining names to columns
 names(dataset) <- col_vect
 dataset$Country <- as.factor(dataset$Country)
 dataset$`ISO-2` <- as.factor(dataset$`ISO-2`)

 dataset
}
