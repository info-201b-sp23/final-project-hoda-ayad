source('server.R')
library(dplyr)
library(tidyr)
library(bslib)
library(markdown)

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

my_theme <- bs_theme(version = 4, bootswatch = "flatly", primary = "#000000", success = "#E50914")


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
    width = 9
  )

)

# Genre Chart Sidebar
genre_sidebar <- sidebarPanel(
  tags$div(class = "form-check-inline",
    checkboxGroupInput(
      "type_select",
      label = "Select type(s) to include",
      choices = list("Movies" = "MOVIE", "Shows" = "SHOW"),
      selected = "MOVIE",
      inline = TRUE
    )
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
  "Genres",
  titlePanel("How does Genre vary by Release Year?"),
  sidebarLayout(
    genre_sidebar, genre_main
  ),
  h2("Explanation of Graph", align="left"),
  p("As media is released over time, what genres dominate in popularity (so that Netflix will buy the rights to them)? This graph explores the release of different genres from 2000-2022, including movies and/or shows. The data is not normalized considering that media is assigned multiple categories and therefore overlapping.")
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
  "IMDB Scores",
  titlePanel("Visualization of IMDB Scores of Shows and Movies"),
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

age_prop_plot <- mainPanel(
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

age_prop_tab <- tabPanel(
  "Age Rating",
  titlePanel("Proportion of Age Rating Over Time"),
  sidebarLayout(
    age_sidebar, age_prop_plot
  ),
  h2("Explanation of Graph", align="left"),
  p("This chart shows the distribution of age rating and their relative proportion
    to each other in the years between 2000-2022. We choose this graph as we wanted 
    to see how trend in the change in age ratings for movies and TV shows in recent years. 
    It shows that in recent years, the proportion of content created for children and 
    teens have decreased, compared to adult and unrated content.")
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
  age_prop_tab,
  IMDb_Scores,
  concl_panel,
  theme = my_theme
)

