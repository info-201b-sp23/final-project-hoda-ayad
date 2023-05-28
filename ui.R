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

ui <- navbarPage(
  "Title",
  intro_panel,
  genre_panel
)