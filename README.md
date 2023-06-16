# Background
Spotify, a highly popular streaming platform for music and podcast content, with a user base of over 320 million monthly users and offers a vast library of 60 million tracks, four billion playlists, and 1.9 million podcasts. Like its prominent tech counterparts, Spotify owes much of its success to data and analytics. By extensively collecting and analyzing listener data, Spotify can promptly detect emerging user trends and swiftly introduce new features or services to leverage them. One of Spotify's key strengths lies in its impressive recommendation engine, which utilizes machine learning (ML) algorithms, natural language processing (NLP), and convolutional neural networks (CNN). This advanced technology enables Spotify to transform historical listening data into personalized playlists and music recommendations.

The focus of this project is to explore how attributes such as danceability, loudness, speechiness, valence, and others influence the popularity of tracks within the Spotify platform.

# Benefit of Analysis
Indeed, this analysis of how attributes like danceability, loudness, speechiness, valence, and others influence track popularity on Spotify can be highly valuable for marketing purposes and enhancing the user experience on the platform. By understanding the impact of these attributes on a song's popularity, Spotify can provide more accurate predictions of a new song's potential popularity even before its official release.

With this information, Spotify can better tailor its recommendations, personalized playlists, and promotional efforts to match user preferences and increase engagement. By leveraging data-driven insights, Spotify can optimize its music curation, advertising strategies, and artist promotion, ultimately enhancing the overall user experience and maximizing the platform's potential for both listeners and music creators.


# Data Preparation
For the analysis of songs played on Spotify and the attributes influencing their popularity, the data set provided in the Kaggle will be utilized. This data set is sourced through the spotifyr package, developed by Charlie Thompson, Josiah Parry, Donal Phipps, and Tom Wolff. The spotifyr package facilitates the acquisition of data directly from Spotify's API, making it convenient to gather your own data or obtain generic metadata. If you are interested in collecting your own data, you can refer to the spotifyr program's webpage for guidance on how to do so.

# Exploratory Data Analysis
Exploratory Data Analysis (EDA) plays a crucial role in extracting meaningful insights from data, especially before building models. EDA helps uncover relevant information that may not be immediately apparent, allowing us to gain a deeper understanding of the data.

By conducting EDA, we can identify patterns, trends, and distributions within the data. This can help us discover relationships between variables, such as correlations or dependencies, which can be valuable for modeling purposes.

Furthermore, EDA enables us to detect outliers or unusual events that may require special attention or preprocessing. Outliers can significantly impact the performance of models and should be carefully handled. It also aids in data cleansing and preparation by identifying missing values, inconsistencies, or errors. It helps ensure the data is in a suitable format for modeling and minimizes the risk of biased or inaccurate results.

## Correlation Between Features
We’ll start by looking at the correlation between the variables. Correlation tells us if the variables are interdependent. The magnitude of the correlation helps in determining the relationship’s strength, whilst the sign helps in determining whether the variables are moving in the same direction or in opposite directions
rewrite in short.
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
![chrome_f11KKuZhCn](https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/1489dfd3-9213-4f68-bd6f-0bd8ccbf7ade)
The correlation plot highlights the presence of strong connections among certain variables. To address multicollinearity, it is necessary to either select one variable from the correlated pair or employ dimensionality reduction techniques.

In this case, the correlation plot indicates a strong relationship between the variables "energy" and "loudness." To further understand this relationship visually, we can plot a scatter plot.
```r
scatt <- ggplot(spotify,aes(x = energy, y = loudness)) 
scatt + geom_point()
```
![rstudio_BB3M5gMk4E](https://github.com/AbhikritiMoti/Spotify-Data-Analysis/assets/73769937/cb65dcd3-ba29-43ef-bc42-111082daf86d)



