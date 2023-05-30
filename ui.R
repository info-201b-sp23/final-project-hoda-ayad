source('server.R')

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

    recent_titles_df <- titles_df %>% 
      group_by(release_year, type) %>%
      filter(release_year >= 2000) %>%
      summarize(num_media = n())

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

Movies_VS_Shows <- tabPanel(
  "Movies Vs. Shows",
  h1("Movies Vs. Shows Visualization", align="center"),
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

ui <- navbarPage(
  "Title",
  intro_panel,
  genre_panel,
  Movies_VS_Shows
)

