# Evolution of music taste in Spain
Using the top 40 list elaborated by the Spanish music radio *Los 40 Principales* we attempt to study the evolution of musical taste in Spain in terms of genre. [Similar projects](https://thedataface.com/2016/09/culture/genre-lifecycles) can be found on the web, ours is just a national version. We expect to see a swift towards *reggaetón* in the decade of 2010s.

## Scraping

The whole project is coded with R. We use the  [rvest](https://rvest.tidyverse.org/) package for scrapping., to obtain the data from the [webpage](https://los40.com/lista40/2005/1) where the playlist is.  The scraper for the gets every top 40 playlist since 2005 (first year on record).

## Classification

We are yet to see how we can manage to assign a genre to every song.

## Plotting

Expect to see animated plots using the [gganimate](https://gganimate.com/) package as well as [Plotly](https://plotly.com/r/). 

