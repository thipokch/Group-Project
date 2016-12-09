library(dplyr)
library(tidyr)
library(scales)

df <- read.csv('data/all-ages.csv')

major_index_list <- structure(as.list.data.frame(df$Major_code),
                              names = as.character(df$Major))

# Update the group of selectionizedInput
c3.group.select.major(df,'Agriculture & Natural Resources')

# Formats data so it could be plotted in distributiongraph
percentileFormat <- function(df, code){
  df %>%
    filter(Major_code %in% code) %>%
    select(Major_code, Major, P25th, Median, P75th) %>%
    gather(key = Name, value = Salaries, P25th, Median, P75th) %>%
    arrange(Major_code, Salaries) %>%
    mutate(percentile = rep(c(25, 50, 75),times = length(code)), 
           percentage = rep(c(25, 50, 25),times = length(code)), 
           accumulate_percent = rep(c(75, 50, 25),times = length(code))
    )
}

# Formats how the distribution graph should be displayed
distributionGraph <- function(df, code){
  df %>%
    percentileFormat(code) %>%
    ggplot(aes(x = Salaries, y = percentage, color = Major, text = Major_code)) +
    geom_smooth(method = 'loess') +
    geom_point(size = 3) +
    scale_x_continuous(labels = comma)
}

# Renders plotly chart
output$chart3 <- renderPlotly({
  ggplotly(
    distributionGraph(df, input$C3.Major.Selected)
  )}
)