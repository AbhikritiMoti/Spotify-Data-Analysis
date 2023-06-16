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
### Correlation Between Features
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
scatt <- ggplot(spotify,aes(x = energy, y = loudness)) 
scatt + geom_point()
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/cb65dcd3-ba29-43ef-bc42-111082daf86d" alt="Screenshot" width="600" height="auto">
<br> <br>

### Density Plots of Variables
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

### Musical positiveness conveyed by a track
Valence is a musical feature that refers to the emotional content of a piece of music. It can be described as the positivity or negativity of the emotions expressed in a song. A measure from 0.0 to 1.0 describes the musical positiveness conveyed by a track. We have made different classes like `Valence value < 0.350` as sad, `0.351 < Valence value < 0.701` as happy `Valence value > 0.700` as Euphoric.
```r
spotify$valence.category<- spotify$valence
View(spotify)

spotify$valence.category[spotify$valence.category >= 0.000 & spotify$valence.category <= 0.350 ] <- "Sad"
spotify$valence.category[spotify$valence.category >= 0.351 & spotify$valence.category <= 0.700 ] <- "Happy"
spotify$valence.category[spotify$valence.category >= 0.701 & spotify$valence.category <= 1.000 ] <- "Euphoric"

spotify$valence.category <- as.factor(spotify$valence.category)

y <- ggplot(spotify) + 
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

ggplotly(y)
```
<img src="https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/6e5bff47-e4ea-471c-9877-d1e8b7fdfee3" alt="Screenshot" width="600" height="auto">
