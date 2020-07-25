library(stringi)
library(lubridate)
library(progress)

playlists <- read.csv('playlists3.csv')[-1]

# Get all genres
filter1 <- unique(playlists$Genre)
genres <- stri_split_fixed(filter1[1], ', ')[[1]]
for (string in filter1){
  new_genres <- stri_split_fixed(string, ', ')[[1]]
  genres <- union(genres,new_genres)
}

# New dataframe for analysis
analysis.df <- as.data.frame(matrix(nrow=810, ncol=length(genres)+2)) # 810 weeks in total
colnames(analysis.df) <- c('Year','Week',genres)
analysis.df[is.na(analysis.df)] = 0 

start_date = as_date('2005-01-01')
date = start_date

pb <- progress_bar$new(total=810)
for (i in 1:810){
  year = year(date)
  week = week(date)
  analysis.df[i,]['Year'] = year
  analysis.df[i,]['Week'] = week
  top40 <- subset(playlists, Year == year & Week == week)
  row.names(top40) <- NULL
  m <- dim(top40)[[1]]
  for (j in 1:m){
    mygenres <- top40[j,]$Genre
    mygenres <- stri_split_fixed(mygenres, ', ')[[1]]
    for (g in mygenres){
      analysis.df[i,][g] <- (analysis.df[i,][g])+1/m
    }
  }
  date = date + as.period(1,'week')
  pb$tick()
}
write.csv(analysis.df, file = 'analysis.csv')
