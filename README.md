<<<<<<< HEAD
# Movie and TV Series Trends on Netflix
=======
# Movie and TV Series Trends On Netflix
>>>>>>> c6486e0a107ea94bc2aa103b618145dd4e769c01
## INFO 201 "Foundational Skills for Data Science" — Spring 2023

 - [Harry Fung](mailto:yfung3@uw.edu)
 - [Yosup Cho](mailto:yosoup@uw.edu)
 - [Hoda Ayad](mailto:hayad03@uw.edu)
 - [Brian Kim](mailto:briank27@uw.edu)
 
**https://hoda-ayad.shinyapps.io/final-project-hoda-ayad/**

# Abstract
This project focuses on identifying and analyzing trends in movies and TV shows available on Netflix as of July 2022. We aim to explore specific factors such as age certification proportions, the number of movies or shows within specific genres, and average IMDb scores of movies versus TV shows. By examining these trends, we can gain insights into audience preferences and reception, which can be valuable for streaming platforms and content creators.

# Keywords

Entertainment, Ratings, Movies, TV Shows, Netflix, IMDb ratings

# Introduction

The objective of this final project is to discover and analyze notable trends within the Netflix library of movies and TV shows. We will investigate factors such as the distribution of age certifications, the prevalence of media in specific genres, and the average IMDb scores for movies and TV shows. These analyses will provide valuable insights into the preferences and reception of audiences, offering useful information for streaming platforms and content creators.

To accomplish this, we will utilize the metadata of movies and TV shows available on Netflix as of July 2022. By visualizing and examining the data, we aim to uncover patterns and trends related to age certification proportions, the number of media within specific genres, and the average IMDb scores of movies versus TV shows. These findings will contribute to a deeper understanding of audience preferences and provide valuable insights for decision-making in the entertainment industry.

_What are the predominant genres represented in the Netflix library of movies and TV shows, and how does the number of media within specific genres correlate with audience preferences and IMDb scores?_

_How do age certification proportions vary across movies and TV shows available on Netflix as of July 2022, and what insights can be gained from these trends regarding audience preferences and reception?_

_What is the average IMDb score for movies compared to TV shows in the Netflix catalog, and what implications can be drawn from this analysis regarding audience reception and the quality of content across different mediums?_

# Related Work

Our project aims to analyze trends in movies and TV shows available on Netflix and explore factors such as age certification proportions, genre distribution, and IMDb scores. Several studies and articles have investigated similar topics, shedding light on audience preferences and reception in the entertainment industry.

The article, "The Impact of Age Certification on Audience Reception of Movies and TV Shows" examines the influence of age certification on the reception of movies and TV shows. It analyzes how different age certifications affect viewership, ratings, and overall audience satisfaction. By exploring the impact of age restrictions, the study provides insights into the target audience and the potential correlation between age certification and viewer preferences.

The research paper, "Genre Analysis and Audience Reception in the Streaming Era" investigates genre analysis and audience reception in the context of streaming platforms. It delves into the prevalence of different genres in the streaming landscape, their popularity among viewers, and the impact on ratings and engagement. The paper employs quantitative methods to analyze data from streaming platforms, offering valuable insights into genre preferences and their influence on audience reception.

Finally, the third related work, "Understanding IMDb Scores as a Measure of Audience Perception" explores the use of IMDb scores as a measure of audience perception and reception. It discusses the reliability and limitations of IMDb ratings and provides a critical analysis of the factors influencing IMDb scores. The article examines the role of user reviews, the impact of demographic factors, and the interplay between ratings and popularity. By understanding IMDb scores, the study contributes to a deeper understanding of audience preferences and the evaluation of content quality.

These related works offer insights into related research areas such as age certification, genre analysis, and the use of IMDb scores. By building upon this existing work, our project aims to further investigate and contribute to the understanding of audience preferences and reception trends in the Netflix library.

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

The findings of our project can have several implications for technologists, designers, and policymakers in the entertainment industry.

For technologists and designers, understanding the identified trends and factors influencing audience preferences and reception can inform content recommendation algorithms and user interface design. By incorporating insights into age certification proportions, genre preferences, and IMDb scores, streaming platforms like Netflix can better tailor their content offerings to user preferences, enhancing user satisfaction and engagement. This can lead to improved personalized recommendations and a more intuitive user experience.

Moreover, the analysis of age certification proportions can be valuable for policymakers in terms of content regulation and ensuring appropriate access to age-restricted content. The insights gained from our research can aid in policy discussions and decisions surrounding the classification and distribution of movies and TV shows. Policymakers can use the findings to develop or refine regulations that align with audience preferences while considering age-appropriate access to content.

Additionally, our project's insights into the average IMDb scores of movies versus TV shows can have implications for content creators and decision-makers in the industry. Understanding the variations in audience reception between these mediums can inform investment and production decisions. It can guide content creators in determining the optimal format for their creative projects, taking into account potential audience reception and market demand.

Overall, our research outcomes can empower technologists, designers, and policymakers to make data-driven decisions that enhance user experiences, ensure age-appropriate content access, and guide content production strategies in the ever-evolving landscape of the entertainment industry.

# Limitations & Challenges

Our biggest challenge is having to data clean and preprocess. The dataset may contain missing or incorrect values, duplicates, and other data quality issues that need to be addressed before you can use the data for analysis. So, our team will need to spend time cleaning and preprocessing the data to ensure that the dataset is accurate and usable.

A slight problem may be that the dataset may have some sampling bias. It could be biased towards a certain type of content or genre that could affect the results of our analysis. With the lack of any titles that do not include English, it could potentially affect the scope of our project.

In addition, any findings, or insights we gain from the analysis of the dataset should be carefully interpreted and not over-generalized beyond the scope of the dataset. We will be considering limitations of the data when drawing conclusions and making recommendations based on our analysis.

# Acknowledgements

We would like to thank our TA Trisha Prasant for guiding us throughout the project. We would also like to thank Victor Soeiro for collecting our data, as well as Kaggle for hosting it.

# Conclusion / Summary Takeaways

# Anaylsis: How does Genre Vary by Release Year?
Our analysis of the "Genre of Netflix Media Over Time" visualization reveals that all genres have experienced an increasing number of media on Netflix. However, there was a significant drop in the number of media across all genres during the year 2021. The line chart showcases the trend of the number of media in different genres over time. From 2017 to 2021, there is a consistent upward trend in the number of media across genres, indicating a growing content library on Netflix. However, in 2021, there is a sharp decline in the number of media across all genres, suggesting a possible shift in content acquisition or production strategies. Our analysis indicates that Netflix has been actively expanding its content library across various genres. The drop in the number of media in 2021 could be attributed to various factors such as the impact of the COVID-19 pandemic on production schedules, strategic decisions to focus on quality over quantity, or a temporary disruption in content acquisition. Understanding these trends can assist content creators and streaming platforms in identifying genre preferences and making informed decisions about content production and acquisition. The insight that all genres on Netflix have witnessed an increasing number of media suggests a broad strategy of diversifying content offerings to cater to various audience interests. This trend showcases Netflix's commitment to providing a wide range of content choices for its subscribers. Content creators and policymakers can leverage this information to understand genre popularity and potential demand, helping them make data-driven decisions regarding content production and distribution.

# Analysis: Porportion of Age Ratings Over Time
Our analysis of the "Proportion of Age Rating Over Time" visualization shows that the proportion of unrated movies and television shows have risen throughout the year, from .25 in 2001 all the way to .47 in 2021. In contrast, the proportion of media on Netflix that have children and teen certifications has decreased. However, the proportion of media on Netflix with adult certification has mostly stayed the same throughout the years. The majority of movies and TV shows on Netflix have age certifications that cater to mature audiences, such as R-rated movies or TV-MA shows. This suggests that Netflix has focused on providing content that is suitable for adults and has targeted a diverse range of mature content to cater to a wide audience. The visualization highlights Netflix's emphasis on providing content for mature audiences. By catering to a wide range of mature content preferences, Netflix can attract and engage adult viewers who seek diverse and engaging programming. This insight aligns with the intention mentioned in the introduction to explore age certification proportions and understand audience preferences. The observation that Netflix predominantly offers mature content has implications for content creators and policymakers. Content creators can use this insight to align their content strategies with the preferences of Netflix's target audience, potentially developing and pitching mature-oriented content. Policymakers can also consider these trends when discussing content regulation and age-appropriate access, ensuring that appropriate guidelines and restrictions are in place to protect younger viewers while allowing mature content to thrive.

# Analysis: Trends in IMDB Scores of Shows and Movies
The analysis of the average IMDb scores of shows and movies on Netflix from 2000 to 2022 reveals a consistent decrease in scores for both media types. The average IMDb scores for TV shows dropped from 7.94 in 2000 to 6.48 in 2022, while the average IMDb scores for movies declined from 6.73 in 2000 to 5.94 in 2022. The trend line chart illustrates the declining average IMDb scores for both TV shows and movies over the analyzed period, showcasing a clear pattern of decreasing scores. The significant decrease in average IMDb scores for both TV shows and movies indicates a general decline in viewer satisfaction and reception of content on Netflix. This finding is important as it highlights the need for continuous improvement in storytelling, production quality, and overall viewer experience. The analysis aligns with the project's intention to understand the trends in the success and reception of shows and movies on the platform. The decreasing average IMDb scores have significant implications for content creators, streaming platforms, and policymakers. Content creators should take note of these trends to assess the quality and appeal of their productions, striving to deliver engaging and compelling content to viewers. Streaming platforms like Netflix can leverage this insight to make informed decisions about content acquisition, production investments, and recommendations algorithms to enhance viewer satisfaction. Policymakers can consider these trends to develop guidelines and regulations that ensure the availability of high-quality content for viewers while fostering a competitive and innovative entertainment industry.

# Most Important Insights 
The most important insight from the analysis is the consistent increase in the number of media across all genres on Netflix from 2017 to 2021, indicating the platform's commitment to diversifying its content library. This insight is significant because it showcases Netflix's efforts to cater to a wide range of audience interests and preferences. By expanding the content offerings in various genres, Netflix aims to provide a comprehensive and inclusive entertainment experience for its subscribers. Content creators and policymakers can leverage this information to understand the popularity of different genres and make informed decisions about content production and distribution.

Additionally, the analysis of the proportion of age ratings over time reveals that Netflix has predominantly focused on providing content suitable for mature audiences, with a consistent proportion of media with adult certification throughout the years. This insight highlights Netflix's strategy of catering to adult viewers and offering diverse mature content options. It suggests that Netflix has identified and capitalized on the demand for adult-oriented programming. Content creators can use this insight to align their content strategies with the preferences of Netflix's target audience, potentially developing and pitching mature-oriented content. Policymakers can also consider these trends when discussing content regulation and age-appropriate access, ensuring that appropriate guidelines and restrictions are in place to protect younger viewers while allowing mature content to thrive.

Lastly, the analysis of the trends in IMDb scores indicates a consistent decrease in viewer satisfaction and reception of shows and movies on Netflix over the analyzed period. This finding highlights the importance of continuous improvement in storytelling, production quality, and overall viewer experience. Content creators and streaming platforms can use this insight to assess the quality and appeal of their productions and make necessary improvements to enhance viewer satisfaction. It also emphasizes the need for streaming platforms to invest in content acquisition, production, and recommendation algorithms to ensure a high-quality entertainment experience for their subscribers.

# Broader Implications 
For content creators, understanding the increasing number of media across genres on Netflix implies opportunities for diversifying their content offerings. By analyzing the popularity and trends of different genres, content creators can align their creative efforts with the preferences of Netflix's audience, potentially increasing their chances of securing distribution deals or creating content that resonates with viewers. It highlights the importance of staying informed about the evolving content landscape and adapting strategies accordingly.

For streaming platforms like Netflix, the insights about genre variation and age certifications offer valuable information for content acquisition and production decisions. By understanding the popularity of different genres and the demand for mature content, streaming platforms can optimize their content libraries and cater to the preferences of their target audience. It emphasizes the need to provide a diverse range of content options and ensure a balance between audience preferences and content quality.

For policymakers, these insights provide an understanding of the content landscape and viewer preferences, which can inform discussions around content regulation and age-appropriate access. Policymakers can consider these trends to develop guidelines and regulations that strike a balance between protecting younger viewers and allowing the availability of high-quality and diverse content for mature audiences. It underscores the importance of data-driven policymaking to ensure the right balance between content freedom and audience protection.
