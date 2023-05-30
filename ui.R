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
  "Movies Vs. Shows",
  h1("Movies Vs. Shows Visualization", align="center"),
  plotlyOutput("MoviesShows_chart"),
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
    min = min(recent_titles_df$year),
    max = max(recent_titles_df$year),
    value = c(2000, 2021),
    sep = ""),
  h2("Findings and Conclusion", align="left"),
  p("Blah blah blah")
)




ui <- navbarPage(
  "Title",
  intro_panel,
  genre_panel,
  Movies_VS_Shows_panel
)