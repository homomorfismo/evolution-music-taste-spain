library(tidyr)
library(lubridate)
library(ISOweek)
library(ggplot2)

# melt the dataframe to plot it later
analysis <- read.csv('analysis2.csv', check.names = FALSE)[-1]
analysis <- na.omit(analysis)
genres <-  setdiff(colnames(analysis),c('Year','Week'))
df <- pivot_longer(analysis, cols = genres, names_to = 'Genre', values_to = 'Fraction')

# convert year-week into one single date
yearweek <- paste(df$Year,'-W',formatC(df$Week,width=2,flag = '0'),'-7', sep = '')
df$Time <- as_date(ISOweek2date(yearweek))
genres.df <- data.frame(1:length(genres),genres)
colnames(genres.df) <- c('Key','Genre')
df <- merge(df, genres.df, by = 'Genre', all = TRUE)


for (time in unique(df$Time)){
  df1 <- subset(df, Time == as_date(time))
  ggplot(df1, aes(Genre, Fraction)) +
    geom_bar(stat='identity',fill=alpha("blue", 0.3), width = df1$Fraction, ) + 
    theme(
      axis.text = element_blank(),
      axis.title = element_blank(),
    )+
    geom_text(aes(label=Genre), angle = 90, size=df1$Fraction*10, hjust = df1$Fraction)
}
  # # gganimate specific bits:
  # labs(title = 'Year: {frame_time}', x = 'Genre') +
  # transition_time(Time) +
  # ease_aes('linear')
