library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
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
  output$genre_plot <- renderPlotly({
    type_filter <- quo(type %in% input$type_select) # use input vector to parse through type to include
    genre_filter <- quo(genres %in% input$genre_select) # use input vector to parse through genres to include
    
    chart_df <- genre_separated_df %>% 
      group_by(release_year, genres, type) %>%
      filter(release_year >= 2000) %>%
      filter(!!type_filter, !!genre_filter) %>% 
      summarise(count = n()) 
    
    genre_ggplot <- ggplot(chart_df, aes(release_year, count, color = genres, 
                                         text = paste("Release Year: ", release_year,
                                                      "<br>Genre: ", genres,
                                                      "<br>Count: ", count))) +
      geom_line(stat = "summary", fun = sum, group = 1) +
      labs(title = "Genres of Netflix Media over Time",
           subtitle = "Includes only media released after the year 2000",
           x = "Release Year",
           y = "Number of Media on Netflix",
           color = "Genre")
    ggplotly(genre_ggplot, tooltip = "text")
  })

  # Trends in Movies and Shows production in 21st century plot
  output$imdb_chart <- renderPlotly({
    low_year <- input$year_selection[1]
    high_year <- input$year_selection[2]
    
    
    recent_titles_df <- titles_df %>% 
      group_by(release_year, type) %>%
      filter(release_year >= 2000) %>%
      summarize(score_average = mean(imdb_score, na.rm = TRUE))
    
    viz_chart <- recent_titles_df %>%
      filter(release_year >= low_year, release_year <= high_year)
    
    imdb_ggplot <- ggplot(viz_chart) +
      geom_line(aes(x = release_year, y = score_average, color = type)) +
      #scale_color_brewer(palette = "Set2") +
      labs(title = "Trends in IMDB Scores of Movies and Shows", x = "Release Year", 
           y = "IMDB Score", color = "Media Type")
    
    ggplotly(imdb_ggplot)
  })
  
  # Age rating proportions over time
  output$age_prop_chart <- renderPlotly({
    age_cert_per_year <- titles_df %>% 
      filter(release_year > input$genre_prop_year_selection[1] & 
               release_year < input$genre_prop_year_selection[2]) %>%
      group_by(release_year, age_certification) %>% summarize(sum=n_distinct(id))
    
    unrated <- age_cert_per_year %>% filter(nchar(age_certification) == 0) %>%
      mutate(age_certification="Unrated")
    
    age_cert_per_year <- age_cert_per_year %>% filter(!nchar(age_certification) == 0)
    
    children <- age_cert_per_year %>% 
      filter(age_certification %in% c("G", "PG", "TV-G", "TV-Y", "TV-Y7")) %>% 
      mutate(age_certification="Children")
    
    teen <- age_cert_per_year %>% 
      filter(age_certification %in% c("PG-13", "TV-14")) %>% 
      mutate(age_certification="Teen")
    
    adult <- age_cert_per_year %>% 
      filter(age_certification %in% c("TV-MA", "R", "NC-17")) %>% 
      mutate(age_certification="Adult")
    
    age_cert_per_year <- full_join(children, teen)
    age_cert_per_year <- full_join(age_cert_per_year, adult)
    age_cert_per_year <- full_join(age_cert_per_year, unrated)
    
    age_cert_per_year <- age_cert_per_year %>% mutate(total=sum(sum)) %>%
      mutate(prop=sum/total, .before = total)
    
    age_cert_prop_chart <- ggplot(age_cert_per_year, 
                         aes(x=release_year, y=prop, fill=age_certification)) +
      
      geom_bar(position="stack", stat="identity")+
      scale_y_continuous(labels = scales::percent) +
      scale_x_continuous(breaks = seq(input$genre_prop_year_selection[1], 
                                      input$genre_prop_year_selection[2], 
                                      ceiling((input$genre_prop_year_selection[2] - input$genre_prop_year_selection[1]) / 4))) +
      labs(x = "Release Year", y = "Proportion",
           title = "Age-Rating Proportions Over Time",
           fill = "Age Certification")
    
    ggplotly(age_cert_prop_chart)
  })

}
