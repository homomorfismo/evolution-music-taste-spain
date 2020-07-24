library(rvest)
library(progress)

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
  wiki <- html_session(search_url(song))
  results <- html_nodes(read_html(wiki), '.mw-search-result-heading')
  song_page <- tryCatch(
                        follow_link(wiki,'canción'),
                        error = function(e){
                          tryCatch(
                            follow_link(wiki,'álbum'),
                            error = function(e){
                              tryCatch(
                              follow_link(wiki,song),
                              error = function(e){
                                tryCatch(
                                  NULL
                                )}
                              )}
                          )}
                        )
  genres <- 'unknown'
  if (!is.null(song_page)){
    infobox <- html_node(read_html(song_page), '.infobox')
    if (length(infobox)>0){
      rows <- html_children(html_children(infobox)[[1]])
      index <- grep('Género',rows)
      if (length(index)>0){
        genres <- html_text(html_children(rows[[index]])[[2]])
        genres <- gsub('^\n', '',genres)
        genres <- gsub('\n', ', ', genres)
      }
    }
  }
  playlists[i,]$Genre <- genres
}


