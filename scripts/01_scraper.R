library(curl)
library(rvest)
library(dplyr)

## List of NASDAQ tickers
tickers <- read.csv("data/reference/nasdaq-tickers-v2.csv") %>%
  select(Symbol, Name)

## Clean up list of NASDAQ tickers - only index funds and common stock/shares

## URL Construction
url.pre <- "https://query1.finance.yahoo.com/v7/finance/download/"
url.post <- "?period1=347003506&period2=1706572800&interval=1d&events=history&includeAdjustedClose=true"

## Download data for each ticker
for (i in 1:nrow(tickers)) {
  current.ticker <- tickers$Symbol[i]
  url.download <- paste0(url.pre, current.ticker, url.post)
  dest <- paste0("data/raw/", current.ticker, ".csv")
  
  tryCatch(
  download.file(url.download,
                dest),
  error = function(e) {
    print(paste("Couldn't find", current.ticker))
  }
  )
  # Sys.sleep(5)
}