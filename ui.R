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
  
  p(strong("Has the choice in actors portrayed in Netflix shows/movies impacted the ratings its viewers give it?"))
  
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

