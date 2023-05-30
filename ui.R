source('server.R')

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

intro_panel <- tabPanel (
  "Introduction",
  titlePanel("Introduction Page"),
  
  br(),
  
  p(strong("Abstract")),
  

  p("Having big names in the cast has always been a key marketing tactic for movies and TV shows alike, but does this strategy actually work? We intend to use the metadata of the shows and movies published on Netflix as of July 2022 to determine whether the major actor(s) credited in a piece of media is a significant indicator of a higher IMDb score as a representation of general reception. Considering there are many different contributing factors to IMDb scores, we will also take into account the number of votes on IMDb, the release year, and the maturity rating of the work to compare the impact on reception."),
  
  br(),
  
  p(strong("Introduction")),
  
  p("For this final project, our group intends to determine whether the actors shown in Netflix movies/shows serve as a reliable indicator of the show/movie’s ratings. We want to see whether there is a direct relationship between the actors used in the shows/movies, and the ratings that the movies/shows receive after its initial release. It is important that we answer this question because of the value our project results can hold for streaming companies and film/show development firms in general, as there have been instances where the actors used did not make up for the low ratings the film/show received. Although it is important that good actors are used to make a good film, we want to see whether using famous actors boost the ratings the show/movie receives compared to using mediocre or lesser-known ones."),
  
  br(),
  
  p("In order to determine this, our group seeks to answer the following (but not limited to) possible research questions:"),
  
  p(strong("What role have actors played in the overall success of a movie?")),
  
  p(strong("What is the relationship between the actors used in Netflix movies/shows and the third-party ratings the movies/show receives (e.g. Rotten Tomato, IMDb)?")),
  
  p(strong("Has the choice in actors portrayed in Netflix shows/movies impacted the ratings its viewers give it?")),
  
  br(),
  
  p(strong("Related Work")),
  
  p("Our group project intends to explore the relationship between the actors casted in a Netflix movie/film and the overall ratings it receives after its initial release. Specifically, as stated in Part 1, we hope to determine whether the actors the movie/show casts is a reliable indicator in determining the overall rating of the show/movie. Below is a couple articles that discuss some films that had great casts, but terrible execution in the movie/show production (e.g. terrible script writing). For example, the Super Mario Bros. Movie (2023) has received mixed reviews because of things such as the execution of the film production. The same applies for the Cats movie discussed in a separate article, but the overall criticism and ratings the film received was consistently negative. What is common amongst both films is that they had an impressive cast, such as Chris Pratt voicing Mario in the Super Mario Bros. Movie and Idris Elba in the film Cats, but poor reviews and ratings from third-party companies like Rotten Tomatoes and IMDb. But whether the casts used in these movies serve as a reliable indicator of why the films were rated poorly remains a question our group intends on answering."),
  
  br(),
 
  p(strong("The Dataset")),
  
  p(strong("Where did you find the data? Please include a link to the data source")),
  
  p("https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies?select=titles.csv"),
     
  p(strong("Who collected the data?")),
    
  p("Victor Soeiro"),
  
  p(strong("How was the data collected or generated?")),
    
  p("All data was collected utilizing the website JustWatch website which provides what streaming services has what shows or movies, IMDB rating, genre, runtime, age restriction, synopsis, and the cast. The atuhor states that the JustWatch website uses ajax to consume their API using GraphQL queries. The data returns as a JSON file. To get the data they need, they used a request package. They created a reference code for the streaming service Netflix to pass it as a GraphQL variable. The website's API uses only one endpoint to get the queries. So, the author changed the parameters and the query to collect the streamings data. The website prevents a robot to get their data without specifying a User-Agent. To bypass, they created request headers. They then created post data and manipulated it to specify which streaming service it will get the data from. Because some streamings have over 3k movies and shows, the query only returns a total of 1960 results, which is not enough to collect all data. The author used the released year filter to create a cluster of items with below 1960 items. They created a loop function to get all titles available on a given streaming service. The returned data the author got was well formatted but was nested. They parse the data to a unique dictionary containing the correctly fields names. With all the functions defined, they group together to get all titles available on a streaming. Finally, created a function to get all titles from all the streaming services."),
  
  p(strong("Why was the data collected?")),

  p("The data set was collected as a web scrapping project. The author wanted to analyze data in fields that they were interested in such as movies, shows, games, and anime."),

  p(strong("How many observations (rows) are in your data?")),

  p("For the credits data set, there are 54314 unique observations. For the movies data set, there are 5850 unique observations."),

  p(strong("How many features (columns) are in the data?")),

  p("There are a total 20 columns. For the credits data set, there are 5 columns. For the movies data set, there are 15 columns."),

  p(strong("What, if any, ethical questions or questions of power do you need to consider when working with this data?")),

  p("There seems to be no ethical questions or questions of power to consider when working with the data."),

  p(strong("Limitations & Challenges")),
  
  br(),
  
  p("Our biggest challenge is having to data clean and preprocess. The dataset may contain missing or incorrect values, duplicates, and other data quality issues that need to be addressed before you can use the data for analysis. So, our team will need to spend time cleaning and preprocessing the data to ensure that the dataset is accurate and usable. A slight problem may be that the dataset may have some sampling bias. It could be biased towards a certain type of content or genre that could affect the results of our analysis. With the lack of any titles that do not include English, it could potentially affect the scope of our project. In addition, any findings, or insights we gain from the analysis of the dataset should be carefully interpreted and not over-generalized beyond the scope of the dataset. We will be considering limitations of the data when drawing conclusions and making recommendations based on our analysis."),
  
  br(),
 
  p(strong("Acknowledgements")),
  
  p("At the moment we have nobody we wish to acknowledge as we are still in the early stages of our research. However we would like to thank Victor Soeiro for collecting our data, as well as Kaggle for hosting it.")


)

# Genre Chart Sidebar
genre_sidebar <- sidebarPanel(
  checkboxGroupInput(
    "type_select",
    label = "Select type(s) to include",
    choices = list("Movies" = "MOVIE", "Shows" = "SHOW"),
    selected = "MOVIE"
  ),
  
  selectInput(
    inputId = "genre_select",
    label = "Select genres to include",
    choices = possible_genres,
    selectize = TRUE,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = c("action","comedy")
  )
)

genre_main <- mainPanel(
  plotlyOutput("genre_plot")
)

genre_panel <- tabPanel(
  "Explore Genres",
  titlePanel("How does Genre vary by Release Year?"),
  p("Some description"),
  sidebarLayout(
    genre_sidebar, genre_main
  )
)

mvs_sidebar <- sidebarPanel(
  slider_widget <- sliderInput(
    inputId = "year_selection",
    label = "Year",
    min = min(recent_titles_df$release_year),
    max = max(recent_titles_df$release_year),
    value = c(min(recent_titles_df$release_year), max(recent_titles_df$release_year)),
    sep = "")
)

mvs_main <- mainPanel(
  plotlyOutput("imdb_chart")
)

IMDb_Scores <- tabPanel(
  "IMDB Scores of Movies and Shows",
  h1("Visualization of IMDB Scores of Shows and Movies", align="center"),
  sidebarLayout(
    mvs_sidebar, mvs_main
  ),
  h2("Explanation of Graph", align="left"),
  p("The purpose of this data visualization is to show trends in the average 
    IMDB scores of shows and movies during the 21st century. This is to 
    determine and understand the overall data trends in how successful shows and 
    movies have fared, which would be measured by the scores of each media type 
    each year, from 2000 to 2022.")
)

concl_panel <- tabPanel(
  "Conlcusion",
  titlePanel("Conclusion and Summary Takeaways"),
  br(), 
  
)
ui <- navbarPage(
  "Movie Stars to 5 Stars: Actor Credits as Indicators of IMDb Score",
  intro_panel,
  genre_panel,
  IMDb_Scores,
  concl_panel
)

