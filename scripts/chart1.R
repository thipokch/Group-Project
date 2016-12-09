# this is the main source file for the popularity tab in our application

library(shiny)
library(dplyr)
library(plotly)

# reads in the data from recent-grads
my.data <- read.csv('data/recent-grads.csv', stringsAsFactors = FALSE)

my.data <- my.data[,2:9]

# builds the list of major selection options, sets the default to 'Agriculture & Natural Resources'
c1.group.select.major(my.data, 'Agriculture & Natural Resources')

# defines function to build a bar graph of major popularity within a specific category
buildBarGraph <- function(df, major) {
  
  # selects the major category of the major
  selected.category <- filter(df, Major_code %in% major) %>%
    select(Major_category)
  
  # filters the data to majors within the major category
  df <- filter(df, Major_category %in% selected.category)
  
  # determines number of majors within category
  num_majors <- nrow(df)
  
  # creates color vector for graph
  colors <- vector(mode = "character", length = num_majors)
  colors[1:num_majors] <- 'rgb(128,133,133)'
  colors[match(major, df$Major_code)] <- 'rgb(144,103,167)' # purple
  
  p <- plot_ly(data = df, x = ~Major, y = ~Total, name = 'Breakdown of Major Category', type = "bar",
               marker = list(color = colors)) %>%
    layout(title = 'Breakdown of Major Category', xaxis = list(showticklabels = FALSE),
           yaxis = list(title = "Number of People with Major"), autosize = FALSE, width = 600, height = 400)
  
  return(p)
  
}

# defines function to build a pie graph of the gender breakdown
buildPie <- function(df, major) {
  
  # filters the data to a selected major
  selected <- filter(df, Major_code %in% major)
  
  # sets the color vector for graph 
  colors <- c('rgb(211,94,96)', 'rgb(114,147,203)')
  
  # creates dataframe of the gender breakdown
  label <- c("Women", "Men")
  totals <- c(selected$Women, selected$Men)
  df <- data.frame(label, totals)
  
  p <- plot_ly(df, labels = ~label, values = ~totals, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(totals),
               marker = list(colors = colors,
                             line = list(color = '#FFFFFF', width = 1)), showlegend = FALSE) %>%
    layout(title = 'Gender Breakdown of Major Graduates',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
  
}

# outputs gender pie graph for the selected major
output$chart1 <- renderPlotly({
  buildPie(my.data, input$C1.Major.Selected)
})

# outputs popularity bar graph for the selected major
output$barChart1 <- renderPlotly({
  buildBarGraph(my.data, input$C1.Major.Selected)
})

