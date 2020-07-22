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
pb <- progress_bar$new(total=n_weeks)
for (k in 1:n_weeks) {
  year = year(date)
  week = week(date)
  url = make_url(year, week)
  los40 <- read_html(url)
  listwrapper <- html_nodes(los40, '.info_grupo')
  # we now get the songs and artists
  top40 <- as.data.frame(matrix(ncol = 3, nrow = 40))
  colnames(top40) <- c('Song', 'Artist', 'Genre')
  for(i in 1:40){
    item = listwrapper[[i]]
    song <- html_text(html_node(item, 'p'))
    artist <- html_text(html_node(item, 'h4 a'))
    genre <- ''  #  do something to get the genres
    top40[i,] <- data.frame(song, artist, genre)
    
  }
  date = date + as.period(1,'week')
  pb$tick()
}