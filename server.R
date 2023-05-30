library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(RColorBrewer)

titles_df <- read.csv("titles.csv")
credits_df <- read.csv("credits.csv")

# Genre Plot DF (needed for UI)
genre_separated_df <- titles_df %>% 
  separate_rows(genres) %>% 
  filter(genres != "") %>% 
  select(-c(description, production_countries, tmdb_popularity, tmdb_score, id))
possible_genres <- unique(genre_separated_df$genres)

server <- function(input, output) {
  
  # Genres Over Time Plot 
  output$genre_plot <- renderPlot({
    type_filter <- quo(type %in% input$type_select) # use input vector to parse through type to include
    genre_filter <- quo(genres %in% input$genre_select) # use input vector to parse through genres to include
    
    chart_df <- genre_separated_df %>% 
      group_by(release_year, genres, type) %>%
      filter(release_year >= 2000) %>%
      filter(!!type_filter, !!genre_filter) %>% 
      summarise(count = n()) 
    
    ggplotly(chart_df, aes(release_year, count, color = genres)) +
      geom_line(stat = "summary", fun = sum) +
      labs(title = "Genres of Netflix Media over Time",
           subtitle = "Includes only media released after the year 2000",
           x = "Release Year",
           y = "Number of Media on Netflix",
           color = "Genre")
  })

# Trends in Movies and Shows production in 21st century plot
  output$Shows_chart <- renderPlot({
    
    recent_titles_df <- titles_df %>% 
      arrange(release_year) %>%
      filter(release_year >= 2000) 
    
    shows_df <- recent_titles_df %>%
      filter(type %in% "SHOW")
    
    movies_df <- recent_titles_df %>%
      filter(type %in% "MOVIE")
    
    show_ggplot <- ggplot(shows_df) +
      geom_line(aes(x = release_year, y = imdb_score, color = title)) +
      labs(title = "Trends in IMDB scores of Shows", x = "Release Year", 
           y = "IMDB Score")
    Shows_chart <- ggplotly(show_ggplot)
 
  return(Shows_chart)
  })
  
}