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
  output$MoviesShows_chart <- renderPlotly({
    low_year <- input$year_selection[1]
    high_year <- input$year_selection[2]
    
    
    recent_titles_df <- titles_df %>% 
      group_by(release_year, type) %>%
      filter(release_year >= 2000) %>%
      summarize(num_media = n())
    
    viz_chart <- recent_titles_df %>%
      filter(release_year >= low_year, release_year <= high_year)
    
    MoviesVSShows_ggplot <- ggplot(viz_chart) +
      geom_line(aes(x = release_year, y = num_media, color = type)) +
      scale_color_brewer(palette = "Set2") +
      labs(title = "Trends in Release of Movies and Shows", x = "Release Year", 
           y = "Number of Media Released")
    
    ggplotly(MoviesVSShows_ggplot)
  })
  
}