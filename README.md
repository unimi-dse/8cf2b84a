
# wbanalysis

This package allows the user to easily access to “The World Bank”
datasets and perform quick analysis.

## Installation

``` r
# wbanalysis can be easily installed from GitHub
devtools::install_github('unimi-dse/8cf2b84a')
```

## Usage

``` r
# Load the package
library(wbanalysis)
```

### Tidy Dataset

The function `wb_tidy()` returns a data frame which columns are the
characteristics of countries and indicators used as parameters of the
function. The resulting dataset respects the principles of tidy data and
is ready to be
used.

``` r
wb_tidy(countries = "IT", indicators = c("NY.GDP.MKTP.CD", "SP.DYN.LE00.IN"))
```

### Correlations analysis

The function `wb_cor()` prints a matrix which values are the
correlations between the chosen indicators for each of the selected
countries.

``` r
wb_cor(countries = c("US", "CN", "RU"), indicators = c("SP.POP.TOTL", "SL.TLF.TOTL.IN", "NY.GDP.PCAP.CD"))
```

### Plotting

The function `wb_plot()` displays a line plot for each indicator.

``` r
wb_plot(countries = "IT", indicators = c("NY.GDP.MKTP.CD"))
```
