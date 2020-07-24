library(rvest)
library(progress)
library(stringi)

playlists <- read.csv('playlists.csv')[-1]
playlists$Genre <- 'unknown'
unique_songs <- unique(playlists[c('Song', 'Artist')])
n <- dim(unique_songs)[1]

search_url <- function(song,artist){
  first <- 'https://www.discogs.com/search/?q='
  last<- '&type=all'
  s <- paste(song,artist)
  s <- URLencode(stri_unescape_unicode(s))
  return(paste(first,s,last,sep=''))
}

pb <- progress_bar$new(total = n)
for(i in 30:n){
  song <- unique_songs[i,]$Song
  artist <- unique_songs[i,]$Artist
  wiki <- html_session(search_url(song, artist))
  results <- html_nodes(read_html(wiki), '#search_results')
  link <- html_attr(html_node(results, xpath = '/html/body/div[1]/div[4]/div[3]/div[3]/div[2]/div[1]/h4/a'), 'href')
  full_link <- paste('https://www.discogs.com/',link,sep = '')
  song_page <- jump_to(wiki, full_link)
  details <- html_nodes(read_html(song_page), '.head')
  index <- grep('Genre',details)
  genres <- html_nodes(read_html(song_page), '.content')[[index]]
  genres <- gsub('\n\\s*','',html_text(genres))
  # assign genre to all appearances of the song in the dataframe
  playlists[playlists$Song == song,]$Genre <- genres
  pb$tick()
}
