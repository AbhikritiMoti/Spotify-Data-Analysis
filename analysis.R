install.packages("ggplot2")
install.packages("tidyverse",dependencies = T)
install.packages("gridExtra",dependencies = T)
install.packages("dplyr",dependencies = T)
install.packages("RColorBrewer",dependencies = T)
install.packages("MASS",dependencies = T)
install.packages("gvlma",dependencies = T)
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("wordcloud2")
install.packages("flexdashboard")
install.packages("highcharter")
install.packages("gt")
install.packages("htmltools")
install.packages("viridis")
install.packages("plotly")
install.packages("treemap")

library(shiny)
library(shinythemes)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(ggcorrplot)
library(dplyr)
library(sqldf)
library(RColorBrewer)
library(MASS)
library(gvlma)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(flexdashboard)
library(highcharter)
library(gt)
library(htmltools)
library(viridis)
library(plotly)
library(treemap)


setwd("D:/OneDrive - Lovely Professional University/LPU Study Materials/SEMESTER 6  ___  05JAN2023 - PRESENT/INT232   DATA SCIENCE TOOLBOX  R PROGRAMMING   3/SpotifyAnalysis")
spotify <- read.csv("D:/OneDrive - Lovely Professional University/LPU Study Materials/SEMESTER 6  ___  05JAN2023 - PRESENT/INT232   DATA SCIENCE TOOLBOX  R PROGRAMMING   3/SpotifyAnalysis/spotify_songs.csv", stringsAsFactors = T)

str(spotify)
View(spotify)
names(spotify)
summary(spotify)
colSums(is.na(spotify))
dim(spotify)

#correlation between the variables
corr <- round(cor(spotify[,c(12:13,15:23)]),8)
gg1 <- ggcorrplot(corr) +
  ggtitle("Correlation between the variables") +
  theme(panel.background = element_rect(fill = "#ebebeb")) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb")) +
  theme(plot.title = element_text(size = 13, face = "bold", colour = "#13833c"),
        text = element_text(size = 10,colour = "#13833c")) +
  theme(axis.text.x = element_text(colour = "#13833c", size = 10))+
  theme(axis.text.y = element_text(colour = "#13833c",size = 10))

ggplotly(gg1)
#It can be observed that the variables [loudness and energy] are correlated to 
#some extent compared to the other variables

#scatterplot to visualize above relationship

scatt <- ggplot(spotify, aes(x = energy, y = loudness)) 
scatt + 
  geom_point(color = "#13833c") +  # Set a base color for the points
  scale_color_viridis_c() +
  theme(axis.text = element_text(color = "darkgreen"),  
        axis.title = element_text(color = "darkgreen"))  

#The graph indicates a strong relationship between the audio features energy and loudness

View(spotify)
dim(spotify)
sapply(spotify, class)

unique(spotify$key)
spotify$key <- as.factor(spotify$key)

#converting the numerical keys to the actual musical keys
levels(spotify$key)[1]  <-"C"
levels(spotify$key)[2]  <-"C#"
levels(spotify$key)[3]  <-"D"
levels(spotify$key)[4]  <-"D#"
levels(spotify$key)[5]  <-"E"
levels(spotify$key)[6]  <-"F"
levels(spotify$key)[7]  <-"F#"
levels(spotify$key)[8]  <-"G"
levels(spotify$key)[9]  <-"G#"
levels(spotify$key)[10] <-"A"
levels(spotify$key)[11] <-"A#"
levels(spotify$key)[12] <-"B"

ggplot(spotify) + geom_bar(aes(key,fill = key),width = 0.5) +
  scale_x_discrete(name = "Key") +
  scale_y_discrete(name = "Count") +
  theme_bw() +
  ggtitle("Most Popular Key") +
  theme(plot.title = element_text(size = 12, face = "bold", colour = "darkgreen"),
        text = element_text(size = 11,colour = "darkgreen")) +
  theme(legend.title=element_blank()) +
  theme(panel.background = element_rect(fill = "#dcdcdc")) +
  theme(plot.background = element_rect(fill = "#dcdcdc")) +
  theme(legend.background = element_rect(fill = "#dcdcdc"))+
  theme(axis.text.x = element_text(colour = "darkgreen",size = 10))+
  theme(axis.text.y = element_text(colour = "darkgreen"))



# Top 10 Artists by Genre
top_genre <- spotify %>% select(playlist_genre, track_artist, track_popularity) %>% 
  group_by(playlist_genre,track_artist) %>% 
  summarise(n = n()) %>% 
  top_n(10, n)

tm <- treemap(top_genre, index = c("playlist_genre", "track_artist"), vSize = "n", 
              vColor = 'playlist_genre', palette =  viridis(7),title="Top 10 Artists by Genre" )
  
# Top 3 Subgenres within each Genre

top <- spotify %>% select(playlist_genre, playlist_subgenre, track_popularity) %>% 
  group_by(playlist_genre,playlist_subgenre) %>% 
  summarise(n = n()) %>% 
  top_n(3, n)
tm <- treemap(top, index = c("playlist_genre", "playlist_subgenre"), vSize = "n", 
              vColor = 'playlist_genre', palette =  viridis(7), ,title="Top 3 Subgenres within each Genre" )

# Top 15 Chart-Topping Songs of All Time

popular_artists <- spotify %>%
  group_by(Songs = track_name) %>%
  summarise(No_of_tracks = n(), Popularity = mean(track_popularity)) %>%
  filter(No_of_tracks > 2) %>%
  arrange(desc(Popularity)) %>%
  top_n(15, wt = Popularity)

ggplot(popular_artists, aes(x = Songs, y = Popularity, fill = Popularity)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top Hit Songs of All Time", x = "Songs", y = "Popularity") +
  scale_fill_viridis_c(option = "D", direction = -1, alpha = 0.8) +
  theme(plot.title = element_text(size = 12, face = "bold", colour = "darkgreen"),
        axis.text.x = element_text(colour = "darkgreen", size = 10),
        axis.text.y = element_text(colour = "darkgreen"),
        text = element_text(size = 11, colour = "darkgreen"),
        legend.title = element_blank(),
        panel.background = element_rect(fill = "#ebebeb"),
        plot.background = element_rect(fill = "#ebebeb"),
        legend.background = element_rect(fill = "#ebebeb"))

ggplotly(popular_artists)

#valence category wise
spotify$valence.category<- spotify$valence

spotify$valence.category[spotify$valence.category >= 0.000 & spotify$valence.category <= 0.350 ] <- "Sad"
spotify$valence.category[spotify$valence.category >= 0.351 & spotify$valence.category <= 0.700 ] <- "Happy"
spotify$valence.category[spotify$valence.category >= 0.701 & spotify$valence.category <= 1.000 ] <- "Euphoric"

spotify$valence.category <- as.factor(spotify$valence.category)

plot <- ggplot(spotify) + 
  geom_bar(aes(valence.category, fill = valence.category), stat = "count") +
  scale_x_discrete(name = "Valence") +
  scale_y_continuous(name = "Count of Songs") +
  theme_bw() +
  ggtitle("Valence wise Category") +
  theme(plot.title = element_text(size = 12, face = "bold", colour = "darkgreen"),
        text = element_text(size = 11,colour = "darkgreen")) +
  theme(legend.title = element_blank()) +
  theme(panel.background = element_rect(fill = "#ebebeb")) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb")) +
  theme(axis.text.x = element_text(colour = "darkgreen",size = 10)) +
  theme(axis.text.y = element_text(colour = "darkgreen"))

ggplotly(plot)
  


# Plotting Density Plots
x<- ggplot(spotify) +
  geom_density(aes(energy, fill ="energy", alpha = 0.1)) + 
  geom_density(aes(danceability, fill ="danceability", alpha = 0.1)) + 
  geom_density(aes(valence, fill ="valence", alpha = 0.1)) + 
  geom_density(aes(acousticness, fill ="acousticness", alpha = 0.1)) + 
  geom_density(aes(speechiness, fill ="speechiness", alpha = 0.1)) + 
  geom_density(aes(liveness, fill ="liveness", alpha = 0.1)) + 
  scale_x_continuous(name = "Energy, Danceability, Valence, Acousticness, Speechiness, Liveness") +
  scale_y_continuous(name = "Density") +
  theme_bw() +
  ggtitle("Density Plots") +
  theme(plot.title = element_text(size = 13, face = "bold", colour = "#13833c"),
        text = element_text(size = 11,colour = "#13833c")) +
  theme(panel.background = element_rect(fill = "#ebebeb")) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb"))+
  theme(axis.text.x = element_text(colour = "#13833c",size = 9))+
  theme(axis.text.y = element_text(colour = "#13833c",size = 9))

ggplotly(x)





#Artists are arranged according to the popularity. 
# Select the top 100 artists based on popularity
top_artists <- spotify %>% 
  group_by(track_artist) %>% 
  summarize(popularity = sum(track_popularity)) %>% 
  arrange(desc(popularity)) %>% 
  slice_head(n = 100)

# Create a word cloud of the top artists
par(bg = "#ebebeb")
wordcloud(words = top_artists$track_artist, 
          freq = top_artists$popularity,
          scale = c(1.6, 0.5), 
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35,
          colors = brewer.pal(12, "Dark2"))






#This plot shows that higher energy songs are popular among Spotify listeners.
#### Histogram of Energy Distribution
spotify$energy_only <- cut(spotify$energy, breaks = 10)

plot <- spotify %>%
  ggplot(aes(x = energy_only )) +
  geom_bar(width = 0.7, fill = "darkgreen", colour = "black", stat = "count") +
  scale_x_discrete(name = "Energy") +
  scale_y_continuous(name = "Count of Songs") +
  ggtitle("Energy Distribution") +
  theme_bw() +
  theme(plot.title = element_text(size = 13, face = "bold", colour = "darkgreen"),
        text = element_text(size = 11,colour = "darkgreen")) +
  theme(axis.text.x = element_text(colour = "darkgreen")) +
  theme(panel.background = element_rect(fill = "#ebebeb"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb")) +
  theme(axis.text.y = element_text(colour = "darkgreen"))

ggplotly(plot)


# Box Plot of genre by valence
# Latin genre has a higher valence than others
ggplot(spotify, aes(x=valence, y=playlist_genre)) +
  geom_boxplot(color="black", fill="darkgreen")  +
  scale_x_continuous(name = "Valence") +
  scale_y_discrete(name = "Genre") +
  theme_bw() +
  ggtitle("Valence of Genre") +
  
  theme(plot.title = element_text(size = 14, face = "bold", colour = "darkgreen"),
        text = element_text(size = 11,colour = "darkgreen")) +
  theme(legend.title=element_blank()) +
  scale_fill_brewer(palette="Accent") + 
  theme(axis.text.x = element_text(colour = "darkgreen"))+
  theme(panel.background = element_rect(fill = "#ebebeb"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb"))+
  theme(axis.text.y = element_text(colour = "darkgreen"))


### Proportion of Genres
custom <- viridis::plasma(n=15)

spoify_genre <- spotify %>% 
  group_by(playlist_genre) %>% 
  summarise(Total_number_of_tracks = length(playlist_genre))

ggplot(spoify_genre, aes(x="", y="", fill=playlist_genre)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) + 
  geom_text(aes(label = paste(round(Total_number_of_tracks / sum(Total_number_of_tracks) * 100, 1), "%")),
            position = position_stack(vjust = 0.5), colour = "#13833c")+
  ggtitle("Proportion of Genres") +
  theme(plot.title = element_text(size = 13, face = "bold", colour = "#13833c"),
        text = element_text(size = 11,colour = "#13833c")) +
  theme(panel.background = element_rect(fill = "#ebebeb")) +
  theme(plot.background = element_rect(fill = "#ebebeb")) +
  theme(legend.background = element_rect(fill = "#ebebeb"))+
  theme(axis.text.x = element_text(colour = "#13833c",size = 9))+
  theme(axis.text.y = element_text(colour = "#13833c",size = 9))



