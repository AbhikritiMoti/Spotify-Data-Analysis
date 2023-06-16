# Background
<a href="https://open.spotify.com/" target="_blank">Spotify</a> a highly popular streaming platform for music and podcast, with a user base of over 517 million monthly users and offers a vast library of 61 million tracks, four billion playlists, and 1.9 million podcasts. Like its prominent tech counterparts, Spotify owes much of its success to data and analytics. By extensively collecting and analyzing listener data, Spotify can promptly detect emerging user trends and swiftly introduce new features or services to leverage them. One of Spotify's key strengths lies in its impressive recommendation engine, which utilizes machine learning (ML) algorithms, natural language processing (NLP), and convolutional neural networks (CNN). This advanced technology enables Spotify to transform historical listening data into personalized playlists and music recommendations.

The focus of this project is to explore how attributes such as danceability, loudness, speechiness, valence, and others influence the popularity of tracks within the Spotify platform.

# Benefit of Analysis
Indeed, this analysis of how attributes like danceability, loudness, speechiness, valence, and others influence track popularity on Spotify can be highly valuable for marketing purposes and enhancing the user experience on the platform. By understanding the impact of these attributes on a song's popularity, Spotify can provide more accurate predictions of a new song's potential popularity even before its official release.

With this information, Spotify can better tailor its recommendations, personalized playlists, and promotional efforts to match user preferences and increase engagement. By leveraging data-driven insights, Spotify can optimize its music curation, advertising strategies, and artist promotion, ultimately enhancing the overall user experience and maximizing the platform's potential for both listeners and music creators.


# Data Preparation
For the analysis of songs played on Spotify and the attributes influencing their popularity, the data set provided in the <a href="https://www.kaggle.com/datasets/ignitedinside/spotifydb" target="_blank">Kaggle</a> will be utilized. The dataset essentially has information about the song such as, track name, artist name, danceability, key of the song, acousticness, speech, tempo, liveness, valence, popularity along 
with other factors that would help us deduce meaningful information in determining if a song can be classified as a hit or not. We would like to know which parameters in the songs will make a bigger appeal to the audience. What type of music styles are often popular , what sort of musics we might enjoy.

# Exploratory Data Analysis
Exploratory Data Analysis (EDA) plays a crucial role in extracting meaningful insights from data, especially before building models. EDA helps uncover relevant information that may not be immediately apparent, allowing us to gain a deeper understanding of the data.

By conducting EDA, we can identify patterns, trends, and distributions within the data. This can help us discover relationships between variables, such as correlations or dependencies, which can be valuable for modeling purposes.

Furthermore, EDA enables us to detect outliers or unusual events that may require special attention or preprocessing. Outliers can significantly impact the performance of models and should be carefully handled. It also aids in data cleansing and preparation by identifying missing values, inconsistencies, or errors. It helps ensure the data is in a suitable format for modeling and minimizes the risk of biased or inaccurate results.
<br> <br>
## Correlation Between Features
We’ll start by looking at the correlation between the variables. Correlation tells us if the variables are interdependent. The magnitude of the correlation helps in determining the relationship’s strength, whilst the sign helps in determining whether the variables are moving in the same direction or in opposite directions.
```r
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
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/1489dfd3-9213-4f68-bd6f-0bd8ccbf7ade" alt="Screenshot" width="600" height="auto">
<br> <br>
The correlation plot highlights the presence of strong connections among certain variables. To address multicollinearity, it is necessary to either select one variable from the correlated pair or employ dimensionality reduction techniques.
In this case, the correlation plot indicates a strong relationship between the variables "energy" and "loudness." To further understand this relationship visually, we can plot a scatter plot.
<br> <br>

```r
scatt <- ggplot(spotify, aes(x = energy, y = loudness)) 
scatt + 
  geom_point(color = "#13833c") +  # Set a base color for the points
  scale_color_viridis_c() +
  theme(axis.text = element_text(color = "darkgreen"),  
        axis.title = element_text(color = "darkgreen"))  
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/b4314a89-3a4d-4d0c-a367-6bd97146d062" alt="Screenshot" width="600" height="auto">
<br> <br>

## Genre Distribution

To visualize the distribution of the variables energy, danceability, valence, acousticness, speechiness, and liveness, we can plot their density plots together. Since all these variables have the same scale and range from 0 to 1, combining them in a single plot can provide a comprehensive view of their distributions.
```r
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
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/2a6463e8-c64f-495b-aecf-37995bdf8935" alt="Screenshot" width="600" height="auto">

<br> <br>

## Musical Positiveness Conveyed by Tracks
The musical feature valence represents the emotional content of a song, specifically indicating the positivity or negativity of the expressed emotions. Valence is measured on a scale from 0.0 to 1.0, where a higher value signifies a more positive emotional tone in the music. In our analysis, we have categorized the valence values into distinct classes based on their ranges. Songs with a `Valence value < 0.350` are classified as sad, `0.351 < Valence value < 0.701` are classified as happy `Valence value > 0.700` are classified as euphoric. This categorization enables us to better understand the emotional qualities conveyed by the tracks in our dataset and provides a framework for exploring the relationship between valence and other attributes in the context of music preferences and experiences.

```r
spotify$valence.category<- spotify$valence
View(spotify)

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
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/6be7107f-5dcc-4f77-9a07-dc6db82d11d0" alt="Screenshot" width="600" height="auto">
<br> <br>

## Top Genres, Subgenres, and Chart-Topping Songs
&#9642; **Let's analyze the top 10 artists within each genre**

```r
top_genre <- spotify %>% select(playlist_genre, track_artist, track_popularity) %>% 
  group_by(playlist_genre,track_artist) %>% 
  summarise(n = n()) %>% 
  top_n(10, n)
tm <- treemap(top_genre, index = c("playlist_genre", "track_artist"), vSize = "n", 
  vColor = 'playlist_genre', palette =  viridis(7),title="Top 10 Artists by Genre" )
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/19b016aa-8972-4766-896d-547a72667d34" alt="Screenshot" width="600" height="auto">
<br> <br>

&#9642; **Top 3 Subgenres within each Genre**

```r
top <- spotify %>% select(playlist_genre, playlist_subgenre, track_popularity) %>% 
  group_by(playlist_genre,playlist_subgenre) %>% 
  summarise(n = n()) %>% 
  top_n(3, n)
tm <- treemap(top, index = c("playlist_genre", "playlist_subgenre"), vSize = "n", 
  vColor = 'playlist_genre', palette =  viridis(7), ,title="Top 3 Subgenres within each Genre" )
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/aa9450ce-f0ae-455b-82c6-42e68959f417" alt="Screenshot" width="600" height="400">
<br> <br>

&#9642; **Top 15 Chart-Topping Songs of All Time**
```r
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
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/282146dd-7d0c-4a84-9fbb-4fb1abf30320" alt="Screenshot" width="600" height="auto">
<br> <br>

## Top 100 Artists Ranked by Popularity

The wordcloud focuses on identifying and showcasing the top 100 artists based on their popularity within the music dataset. Popularity is determined by the sum of track popularity scores associated with each artist. 
Exploring these artists allows for a deeper understanding of the musical landscape and provides valuable insights into the artists who have achieved widespread recognition and appreciation.

```r
top_artists <- spotify %>% 
  group_by(track_artist) %>% 
  summarize(popularity = sum(track_popularity)) %>% 
  arrange(desc(popularity)) %>% 
  slice_head(n = 100)
  
par(bg = "#ebebeb")
wordcloud(words = top_artists$track_artist, 
          freq = top_artists$popularity,
          scale = c(1.6, 0.5), 
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35,
          colors = brewer.pal(12, "Dark2"))
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/533d50d4-c7ff-48bd-bb3f-e8cd76846df2" alt="Screenshot" width="600" height="auto">
<br> <br>

## Analyzing the Energy Distribution in Songs

Analyzing the energy distribution of songs can offer several benefits. It allows music enthusiasts, artists, and industry professionals to gain a deeper understanding of listeners' preferences and trends. This information can aid in curating playlists, designing music recommendations, and making informed decisions regarding music production and marketing strategies. 

```r
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
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/bd8bfa89-4dcd-4cc5-8e48-bfb66384d363" alt="Screenshot" width="600" height="auto">
<br> <br>

## Valence Range Across Different Genres

The box plot analysis examines the relationship between the valence (measure of positivity) of songs and their corresponding genres. Understanding the valence of genres can be beneficial in several ways. It can assist music enthusiasts, researchers, or industry professionals in understanding the emotional appeal and preferences associated with various genres.

```r
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
```

<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/daee2c6c-ddb4-40cc-93e4-a239fd560694" alt="Screenshot" width="600" height="auto">
<br> <br>

## Genre Distribution

By analyzing the proportion of tracks within each genre, we can gain a better understanding of the diversity and popularity of different music styles.

```r
custom_palette <- c("#1DB954", "#1ED760", "#0d632b", "#063014", "#010904", "#138a3d", "#0b5626", 
  "#004B6B", "#005A5B", "#006954", "#007840", "#20B200", "#4EBA00", "#7DB000", "#A2B500")


spoify_genre <- spotify %>% 
  group_by(playlist_genre) %>% 
  summarise(Total_number_of_tracks = length(playlist_genre))

ggplot(spoify_genre, aes(x = "", y = "", fill = playlist_genre)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start = 0) + 
  geom_text(aes(label = paste(round(Total_number_of_tracks / sum(Total_number_of_tracks) * 100, 1), "%")),
            position = position_stack(vjust = 0.5), color = "white", size = 3) +
  ggtitle("Proportion of Genres") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#13833c"),
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.background = element_rect(fill = "#ebebeb"),
    legend.position = "bottom",
    legend.background = element_rect(fill = "#ebebeb"),
    legend.title = element_blank(),
    legend.text = element_text(color = "#13833c", size = 9),
    legend.box = "horizontal", # Add legend in a box
    legend.box.just = "center", # Align the legend box to the center
    legend.box.background = element_rect(color = "#13833c", fill = "white"), # Customize the legend box background
    plot.margin = margin(5, 5, 5, 5)
  ) +
  scale_fill_manual(values = custom_palette) + # Change pie colors to shades of Spotify green
  theme(panel.grid = element_blank(), 
        panel.border = element_blank(), 
        axis.ticks = element_blank(), 
        axis.line = element_blank())
```

<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/31f10224-4669-4342-82c0-f1728a621c10" alt="Screenshot" width="auto" height="auto">
<br> <br> <br>


# Creating a FlexDashboard

```r
---
title: "Spotify Data Analysis"
output: 
  flexdashboard::flex_dashboard:
    orientation: columns
    vertical_layout: fill

---
<style>                     
.navbar {
  background-color:#13833c;
  border-color:black;
}
.navbar-brand {
color:black!important;
}

.navbar-inverse .navbar-nav>li > a:hover, .navbar-inverse .navbar-nav > li > a:focus {
  color: #0f0f0f;
  background-color: #0f0f0f;
}

</style>  


```{r setup, include=FALSE}
```

Column {.tabset .tabset .tabset .tabset .tabset .tabset-fade data-width=700}
-----------------------------------------------------------------------

### Chart 1
```{r}
```   
 
### Chart 2 and so on   
```{r}
```

Column {data-width=400}
-----------------------------------------------------------------------
### Chart n
```{r}
```  
