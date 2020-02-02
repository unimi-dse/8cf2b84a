#' wb_analysis: World Bank Data Analysis
#'
#' Returns a data frame of the chosen indicators for the selected countries; displays plots for each indicator and prints a correlation matrix in case of two or more indicators.
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
#' It also prints plots for each indicators and, if there are more than one, the correlation matrix.
#'
#' @examples
#' wb_analysis(countries = "IT", indicators = c("NY.GDP.MKTP.CD", "SP.DYN.LE00.IN"))
#'
#' wb_analysis(countries = c("US", "CN", "RU"), indicators = c("SP.POP.TOTL", "SL.TLF.TOTL.IN", "NY.GDP.PCAP.CD"))
#'
#' @export
wb_analysis <- function(countries, indicators) {

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

 # Computing correlations
 if (length(indicators) > 1) {
  for (c in countries) {
   country_data <- dataset %>% filter(.[[1]] == c)
   print(c)
   print(cor(country_data[, -c(1, 2, 3)], use = "complete.obs"))
  }
 }

 # Plotting
 index <- 4
 for (i in indicators) {
  show(dataset %>%
        ggplot(aes(.[[3]], .[[index]], col = .[[1]])) +
        geom_line() +
        labs(x = col_vect[3], y = col_vect[index], colour = col_vect[2]))
  index <- index + 1
 }

 dataset
}
