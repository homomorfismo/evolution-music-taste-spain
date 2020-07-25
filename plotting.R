library(gganimate)
library(tidyr)
library(lubridate)
library(ISOweek)

# melt the dataframe to plot it later
analysis <- read.csv('analysis.csv', check.names = FALSE)[-1]
analysis <- na.omit(analysis)
genres <-  setdiff(colnames(analysis),c('Year','Week'))
df <- pivot_longer(analysis, cols = genres, names_to = 'Genre', values_to = 'Fraction')

# convert year-week into one single date
yearweek <- paste(df$Year,'-W',formatC(df$Week,width=2,flag = '0'),'-7', sep = '')
df$Time <- ISOweek2date(yearweek)
genres.df <- data.frame(1:length(genres),genres)
colnames(genres.df) <- c('Key','Genre')
df <- merge(df, genres.df, by = 'Genre', all = TRUE)
# # code for labels in the circle barplot
# # ----- ------------------------------------------- ---- #
# # Get the name and the y position of each label
# genres.df <- data.frame(1:length(genres),genres)
# colnames(genres.df) <- c('Key','Genre')
# labels.df <- merge(df, genres.df, by = 'Genre', all = TRUE)
# 
# # calculate the ANGLE of the labels
# angle <-  90 - 360 * (labels.df$Key-0.5) /  length(genres)   # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
# 
# # calculate the alignment of labels: right or left
# # If I am on the left part of the plot, my labels have currently an angle < -90
# labels.df$hjust <- ifelse( angle < -90, 1, 0)
# labels.df$angle <- ifelse(angle < -90, angle+180, angle)
# # ----- ------------------------------------------- ---- #
df1 <- subset(df, Year == 2005 & Week == 1)
ggplot(df1, aes(Key, Fraction)) +
  geom_bar(stat='identity',fill=alpha("blue", 0.3), width = df1$Fraction, ) + 
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
  )+
  geom_text(aes(label=Genre), angle = 90, size=df1$Fraction*10, hjust = df1$Fraction)
  # # gganimate specific bits:
  # labs(title = 'Year: {frame_time}', x = 'Genre') +
  # transition_time(Time) +
  # ease_aes('linear')
