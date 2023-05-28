library(ggplot2)
library(dplyr)
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
    
    ggplot(chart_df, aes(release_year, count, color = genres)) +
      geom_line(stat = "summary", fun = sum) +
      labs(title = "Genres of Netflix Media over Time",
           subtitle = "Includes only media released after the year 2000",
           x = "Release Year",
           y = "Number of Media on Netflix",
           color = "Genre")
  })
  
  
}