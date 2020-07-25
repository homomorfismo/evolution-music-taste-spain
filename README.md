# Evolution of music taste in Spain
Using the top 40 list elaborated by the Spanish music radio *Los 40 Principales* we attempt to study the evolution of musical taste in Spain in terms of genre. [Similar projects](https://thedataface.com/2016/09/culture/genre-lifecycles) can be found on the web, mine is just a national version. We expect to see a swift towards *reggaetón* in the decade of 2010s.

## Scraping

The whole project is coded with R. We use the  [rvest](https://rvest.tidyverse.org/) package for scrapping., to obtain the data from the [webpage](https://los40.com/lista40/2005/1) where the playlist is.  The scraper for the gets every top 40 playlist since 2005 (first year on record).

### Known issues

* The program sometimes halts during execution flagging an error  like`in open.connection(x, "rb") : HTTP error 503`. Fortunately, since the loop is not executed inside a function all variables are global variables and one can look up the value for `k`, which is the loop variable, and start the loop from `k = 347` for example. We will try to automate the process so that no manual restart is needed.

## Classification

I use the [Discogs](www.discogs.com) database and instead of scraping the page we use the [API](https://www.discogs.com/developers/) (among other things, because we tried scraping but server complaint of too many requests). For this we use Python because there is [Python client library](https://github.com/discogs/discogs_client) (which is now deprecated, nonetheless is the one we used).  Multiple genres are assigned to the same song so later we will need a way to consider them separately.

Not all songs are assigned a genre successfully, but the number of songs which are left unclassified is small and the dataset could be completed by hand.

Afterwards 

### Known issues

* The program sometimes halts during execution flagging different errors: too many requests, disconnected from server, too many retries, etc. Fortunately, since the loop is not executed inside a function all variables are global variables and one can look up the value for `i`, which is the loop variable, and start the loop from `i = 347` for example.Wewill try to automate the process so that no manual restart is needed.

## Analysis



## Plotting

Expect to see animated plots using the [gganimate](https://gganimate.com/) package as well as [Plotly](https://plotly.com/r/). 

