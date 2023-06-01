source('server.R')
library(tidyr)

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

recent_titles_df <- titles_df %>% 
  group_by(release_year, type) %>%
  filter(release_year >= 2000) %>%
  summarize(num_media = n())

intro_panel <- tabPanel (
  "Introduction",
  titlePanel("Introduction"),
  
  sidebarPanel(
    img(src = "https://www.freepnglogos.com/uploads/netflix-logo-text-emblem-31.png", width = "100%", height = "100%"),
    
    br(),
    
    img(src = "https://www.freepnglogos.com/uploads/film-reel-png/film-reel-the-movies-owens-valley-12.png", width = "100%", height = "100%"),
    width = 3
  ),
  
  
  mainPanel(
    includeMarkdown("introduction.Rmd"),
    width = 6
  )

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
    step = 1,
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

genre_prop_plot <- mainPanel(
  plotlyOutput("age_prop_chart")
)

age_sidebar <- sidebarPanel(
  slider_widget <- sliderInput(
    inputId = "genre_prop_year_selection",
    label = "Year",
    min = min(recent_titles_df$release_year),
    max = max(recent_titles_df$release_year),
    value = c(min(recent_titles_df$release_year), max(recent_titles_df$release_year)),
    step = 1,
    sep = "")
)

genre_prop_tab <- tabPanel(
  "Proportion of age rating over time",
  sidebarLayout(
    age_sidebar, genre_prop_plot
  )
)

concl_panel <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion and Summary Takeaways"),
  
  includeMarkdown("conclusion.Rmd")
  
)
ui <- navbarPage(
  "Movie and TV Series Trends on Netflix",
  intro_panel,
  genre_panel,
  genre_prop_tab,
  IMDb_Scores,
  concl_panel
)

