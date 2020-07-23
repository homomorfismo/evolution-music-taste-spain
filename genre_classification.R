library(rvest)
playlists <- read.csv('playlists.csv')[-1]
n <- dim(playlists)[1]

search_url <- function(song){
  first <- 'https://es.wikipedia.org/w/index.php?sort=relevance&search='
  last <-'&title=Especial:Buscar&profile=advanced&fulltext=1&advancedSearch-current=%7B%7D&ns100=1&ns104=1&ns0=1'
  s <- URLencode(song)
  return(paste(first,s,last,sep=''))
}

for(i in 1:n){
  song <- playlists$Song[i]
  results <- html_nodes(read_html(search_url(song)), '.mw-search-results')
  
  if (regexpr('canción', ) != -1) {
    
  } else if ((regexpr('álbum', s) != -1))
}