## Combiner
library(data.table)
library(dplyr)

## List of downloads
downloaded.files <- list.files("data/raw") %>%
  str_remove(".csv")

## Combine
combined.data <- fread(paste0('data/raw/', downloaded.files[1], '.csv')) %>%
  mutate(Symbol = downloaded.files[1])

for (i in 2:length(downloaded.files)) {
  temp <- fread(paste0('data/raw/', downloaded.files[i], '.csv')) %>%
    mutate(Symbol = downloaded.files[i])
  tryCatch(
  combined.data <- rbind(combined.data, temp),
  error = function(e) {
    print(paste("Couldn't bind", downloaded.files[i]))
  }
  )
}

## Write out the combined dataset
fwrite(combined.data,
       'data/processed/Raw_CombinedData.csv',
       row.names = F)