source('server.R')

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")


intro_panel <- tabPanel (
  "Introduction",
  titlePanel("[INSERT TITLE]"),
  br(),
  
  p("text")
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
  plotOutput("genre_plot")
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
  select_widget <-
    selectInput(
     inputId = "title_selection",
     label = "Movie/Show Titles",
     choices = recent_titles_df$title,
     selectize = TRUE,
     multiple = TRUE),
  
  slider_widget <- sliderInput(
    inputId = "year_selection",
    label = "Year",
    min = min(recent_titles_df$release_year),
    max = max(recent_titles_df$release_year),
    value = c(min(recent_titles_df$release_year), max(recent_titles_df$release_year)),
    sep = "")
)

mvs_main <- mainPanel(
  plotlyOutput("MoviesShows_chart")
)

Movies_VS_Shows <- tabPanel(
  "Movies Vs. Shows",
  h1("Movies Vs. Shows Visualization", align="center"),
  sidebarLayout(
    mvs_sidebar, mvs_main
  ),
  h2("Findings and Conclusion", align="left"),
  p("Blah blah blah")
)


ui <- navbarPage(
  "Title",
  intro_panel,
  genre_panel,
  Movies_VS_Shows
)