## Checking which stocks were available
library(dplyr)

## Load Original List of tickers
tickers <- read.csv("data/reference/nasdaq-tickers-v2.csv") %>%
  select(Symbol, Name)

## List of downloaded files
downloaded.files <- list.files("data/raw") %>%
  str_remove(".csv")

## Check existence
tickers$Downloaded <- ifelse(tickers$Symbol %in% downloaded.files,
                             1,
                             0)

## List of non-downloads
failed.downloads <- tickers[which(tickers$Downloaded == 0),]

## Save list of failed downloads
write.csv(failed.downloads,
          'data/reference/FailedDownloads.csv',
          row.names = F)