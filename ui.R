source('server.R')

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

recent_titles_df <- titles_df %>%
  arrange(release_year) %>%
  filter(release_year >= 2000)


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
    choices = list("Shows" = "SHOW", "Movies" = "MOVIE"),
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

Movies_VS_Shows_panel <- tabPanel(
  "IMDB Scores of Shows in 21st Century",
  h1("Shows IMDB Score Visualization", align="center"),
  plotlyOutput("Shows_chart"),
  select_widget <-
    selectInput(
      inputId = "title_selection",
      label = "Show Titles",
      choices = shows_df$title,
      selectize = TRUE,
      multiple = TRUE),
  
  slider_widget <- sliderInput(
    inputId = "year_selection",
    label = "Year Show was Scored",
    min = min(shows_df$year),
    max = max(shows_df$year),
    value = c(2000, 2021),
    sep = "")
)

ui <- navbarPage(
  "Title",
  intro_panel,
  genre_panel,
  Movies_VS_Shows_panel
)