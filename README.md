# Movie Stars to 5 Stars: Actor Credits as Indicators of IMDb Score
## INFO 201 "Foundational Skills for Data Science" — Spring 2023

 - [Harry Fung](mailto:yfung3@uw.edu)
 - [Yosup Cho](mailto:yosoup@uw.edu)
 - [Hoda Ayad](mailto:hayad03@uw.edu)
 - [Brian Kim](mailto:briank27@uw.edu)
 
**Link: Link to your Shiny App here**

# Abstract

Having big names in the cast has always been a key marketing tactic for movies and TV shows alike, but does this strategy actually work? We intend to use the metadata of the shows and movies published on Netflix as of July 2022 to determine whether the major actor(s) credited in a piece of media is a significant indicator of a higher IMDb score as a representation of general reception. Considering there are many different contributing factors to IMDb scores, we will also take into account the number of votes on IMDb, the release year, and the maturity rating of the work to compare the impact on reception.

# Keywords

Entertainment, Ratings, Movies, Shows, Netflix, IMDB ratings

# Introduction 

For this final project, our group intends to determine whether the actors shown in Netflix movies/shows serve as a reliable indicator of the show/movie’s ratings. We want to see whether there is a direct relationship between the actors used in the shows/movies, and the ratings that the movies/shows receive after its initial release. It is important that we answer this question because of the value our project results can hold for streaming companies and film/show development firms in general, as there have been instances where the actors used did not make up for the low ratings the film/show received. Although it is important that good actors are used to make a good film, we want to see whether using famous actors boost the ratings the show/movie receives compared to using mediocre or lesser-known ones. In order to determine this, our group seeks to answer the following (but not limited to) possible research questions:

_What role have actors played in the overall success of a movie?_

_What is the relationship between the actors used in Netflix movies/shows and the third-party ratings the movies/show receives (e.g. Rotten Tomato, IMDb)?_

_Has the choice in actors portrayed in Netflix shows/movies impacted the ratings its viewers give it?_

# Related Work

Our group project intends to explore the relationship between the actors casted in a Netflix movie/film and the overall ratings it receives after its initial release. Specifically, as stated in Part 1, we hope to determine whether the actors the movie/show casts is a reliable indicator in determining the overall rating of the show/movie. Below is a couple articles that discuss some films that had great casts, but terrible execution in the movie/show production (e.g. terrible script writing). For example, the Super Mario Bros. Movie (2023) has received mixed reviews because of things such as the execution of the film production. The same applies for the Cats movie discussed in a separate article, but the overall criticism and ratings the film received was consistently negative. What is common amongst both films is that they had an impressive cast, such as Chris Pratt voicing Mario in the Super Mario Bros. Movie and Idris Elba in the film Cats, but poor reviews and ratings from third-party companies like Rotten Tomatoes and IMDb. But whether the casts used in these movies serve as a reliable indicator of why the films were rated poorly remains a question our group intends on answering.

# The Dataset

> Where did you find the data? Please include a link to the data source

<https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies?select=titles.csv>

> Who collected the data?

Victor Soeiro

> How was the data collected or generated?

All data was collected utilizing the website JustWatch website which provides what streaming services has what shows or movies, IMDB rating, genre, runtime, age restriction, synopsis, and the cast. The atuhor states that the JustWatch website uses ajax to consume their API using GraphQL queries. The data returns as a JSON file. To get the data they need, they used a request package. They created a reference code for the streaming service Netflix to pass it as a GraphQL variable. The website's API uses only one endpoint to get the queries. So, the author changed the parameters and the query to collect the streamings data. The website prevents a robot to get their data without specifying a User-Agent. To bypass, they created request headers. They then created post data and manipulated it to specify which streaming service it will get the data from. Because some streamings have over 3k movies and shows, the query only returns a total of 1960 results, which is not enough to collect all data. The author used the released year filter to create a cluster of items with below 1960 items. They created a loop function to get all titles available on a given streaming service. The returned data the author got was well formatted but was nested. They parse the data to a unique dictionary containing the correctly fields names. With all the functions defined, they group together to get all titles available on a streaming. Finally, created a function to get all titles from all the streaming services.

> Why was the data collected?

The data set was collected as a web scrapping project. The author wanted to analyze data in fields that they were interested in such as movies, shows, games, and anime.

> How many observations (rows) are in your data?

For the credits data set, there are 54314 unique observations. For the movies data set, there are 5850 unique observations.

> How many features (columns) are in the data?

There are a total 20 columns. For the credits data set, there are 5 columns. For the movies data set, there are 15 columns.

> What, if any, ethical questions or questions of power do you need to consider when working with this data?

There seems to be no ethical questions or questions of power to consider when working with the data.

> What are possible limitations or problems with this data? (at least 200 words)

One possible limitation with the data set is incompleteness. The dataset may not contain all of the titles available on Netflix, as it is based on a web-scraping process that may have missed certain titles or not captured all of the relevant information for each title. Another limitation might be accuracy. The information provided for each title, such as the release year, genre, and rating, may not always be accurate or up-to-date. Additionally, there may be errors or inconsistencies in the data due to the web-scraping process. In addition, language may be another limitation. Since the dataset is primarily focused on content available in English, it may limit its usefulness for analyzing Netflix's offerings in non-English-speaking countries. The dataset does not include a lot of metadata about each title, such as plot summaries, which could limit the types of analyses that can be performed. There may also be some bias in the data set as well. It may be biased towards certain types of content or genres, depending on the web-scraping process used to collect the data. Finally, the lack of context may deem a problem. The dataset does not provide any context about how Netflix categorizes or recommends content to users, which could limit the usefulness of the data for understanding how Netflix's recommendation algorithm works.

# Implications

There are several stakeholders in our analysis of the correlation between an actor and their average movie rating. For instance movie studio producers may potentially wish to select for a certain role depending on how well said actor is regarded by the audience, judging on how well their previous movies were received. While this is great for studios to ensure that their investment is stable, it also runs the risk of improper casting of actors in an attempt to minimize potential risks. Actors would also likely wish to know their general movie ratings and reflect on their movie choices. In real life movie casting is based on many factors, such as an actor's experience and the character played, while our analysis only look at the correlation between actor and rating. This runs the risk of oversimplifying movie reception to only being impacted by the actors involved, when in reality it is more complex than such.

# Limitations & Challenges

Our biggest challenge is having to data clean and preprocess. The dataset may contain missing or incorrect values, duplicates, and other data quality issues that need to be addressed before you can use the data for analysis. So, our team will need to spend time cleaning and preprocessing the data to ensure that the dataset is accurate and usable.

A slight problem may be that the dataset may have some sampling bias. It could be biased towards a certain type of content or genre that could affect the results of our analysis. With the lack of any titles that do not include English, it could potentially affect the scope of our project.

In addition, any findings, or insights we gain from the analysis of the dataset should be carefully interpreted and not over-generalized beyond the scope of the dataset. We will be considering limitations of the data when drawing conclusions and making recommendations based on our analysis.

# Acknowledgements

At the moment we have nobody we wish to acknowledge as we are still in the early stages of our research. However we would like to thank Victor Soeiro for collecting our data, as well as Kaggle for hosting it.

# Conclusion / Summary Takeaways

