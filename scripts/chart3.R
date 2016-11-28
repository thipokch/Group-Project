library(shiny)
library(dplyr)
library(tidyr)
library(plotly)

df3 <- read.csv('data/all-ages.csv')

major_index_list <- structure(as.list.data.frame(df3$Major_code),
                       names = as.character(df3$Major))

updateSelectizeInput(session, 'C3_Major_Selected', choices = 
                       major_index_list) 

percentileFormat <- function(df, code){
  df %>%
    filter(Major_code %in% code) %>%
    select(Major_code, Major, P25, P50, P75) %>%
    gather(key = Percentile, value = Salaries, P25, P50, P75) %>%
    arrange(Major_code, Salaries) %>%
    mutate(percentile = rep(c(25, 50, 75),times = length(code)), 
           percentage = rep(c(25, 50, 25),times = length(code)), 
           accumulate_percent = rep(c(75, 50, 25),times = length(code))
    )
}

distributionGraph <- function(df, code){
  df %>%
    percentileFormat(code) %>%
    ggplot(aes(x = Salaries, y = percentage, color = Major)) +
    geom_point(size = 3) +
    geom_smooth()
}

stackGraph <- function(df, code){
  df %>%
    arrange(P25) %>%
    mutate(P25_50 = P50 - P25, P50_75 = P75-P50) %>%
    plot_ly(x = ~Major, y = ~P25, type = 'bar', name = '25th Percentile') %>%
    add_trace(y = ~P25_50, name = '50th Percentile') %>%
    add_trace(y = ~P50_75, name = '75th Percentile') %>%
    layout(yaxis = list(title = 'Count'), barmode = 'stack')
}

# ggplotly(distributionGraph(df3, c(1100,1501, 1101)))
# ggplotly(stackGraph(df3, c(1100,1501, 1101)))

