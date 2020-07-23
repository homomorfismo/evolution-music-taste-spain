library(rvest)
library(lubridate)
library(progress)

make_url <- function(year, week){
  return(paste('https://los40.com/lista40/',year,'/',week, sep = ''))
}

start_date = as_date('2005-01-01')
today = lubridate::today()-as.period(1,'week')
date = start_date
n_weeks = as.numeric(floor((today-start_date)/7))

playlists <- as.data.frame(matrix(ncol = 6, nrow = n_weeks))
colnames(playlists) <- c('Song', 'Artist','Genre', 'Rank', 'Year', 'Week')
pb <- progress_bar$new(total=n_weeks)
j = 1
for (k in 1:n_weeks) {
  year = year(date)
  week = week(date)
  url = make_url(year, week)
  los40 <- read_html(url)
  listwrapper <- html_nodes(los40, '.info_grupo')
  l <- length(listwrapper)
  for(i in 1:l){
    item = listwrapper[[i]]
    song <- html_text(html_node(item, 'p'))
    artist <- html_text(html_node(item, 'h4 a'))
    playlists[j,] <- data.frame(song, artist,'unknown', i, year, week)
    j = j+1
  }
  date = date + as.period(1,'week')
  pb$tick()
}
write.csv(playlists, file = 'playlists.csv')