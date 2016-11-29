library(dplyr)
library(tidyr)

df3 <- read.csv('data/all-ages.csv')

# colnames(df3) <- c("Major_code", "Major", "Major_category", "Total", "Employed", 
#                    "Employed_full_time_year_round", "Unemployed", "Unemployment_rate",
#                    "P50", "P25", "P75") 

text.select.major('C3.major.selected', '1100')

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

distributionGraph <- function(df, code){
  df %>%
    percentileFormat(code) %>%
    ggplot(aes(x = Salaries, y = percentage, color = Major)) +
    geom_point(size = 3) +
    geom_smooth(method = 'loess') +
    theme(legend.position = "bottom", legend.box = "horizontal")
}

output$chart3 <- renderPlotly({
  ggplotly(
      distributionGraph(df3, input$C3.major.selected)
  )
})

# stackGraph <- function(df, code){
#   df %>%
#     arrange(P25th) %>%
#     mutate(P25th_50 = Median - P25th, Median_75 = P75th-Median) %>%
#     plot_ly(x = ~Major, y = ~P25th, type = 'bar', name = '25th Percentile') %>%
#     add_trace(y = ~P25th_50, name = '50th Percentile') %>%
#     add_trace(y = ~Median_75, name = '75th Percentile') %>%
#     layout(yaxis = list(title = 'Count'), barmode = 'stack')
# }

# ggplotly(distributionGraph(df3, c(1100,1501, 1101)))
# ggplotly(stackGraph(df3, c(1100,1501, 1101)))

