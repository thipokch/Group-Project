library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)

my.data <- read.csv('data/recent-grads.csv')

my.data <- my.data[,2:9]

text.select.major('Selection_Chart1', '1100')

# updateSelectizeInput(session, 'Selection_Chart1', choices = by.major$Major, selected = 'ACCOUNTING') 

buildBarGraph <- function(df, major) {
  
  selected.category <- df[df$Major == major, 3]
  df <- filter(df, Major_category == selected.category)
  
  p <- plot_ly(data = df, x = ~Major, y = ~Total, name = 'Breakdown of Major Category', type = "bar")
  
  return(p)
  
}


buildPie <- function(df, major) { 
  
  selected <- filter(df, Major == major)
  
  colors <- c('rgb(211,94,96)', 'rgb(114,147,203)')
  
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
          layout(title = 'Breakdown of Recent Graduates by Gender',
            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

  return(p)
  
}


output$chart1 <- renderPlotly({
  buildPie(my.data, input$Selection_Chart1)
})

output$barChart1 <- renderPlotly({
  buildBarGraph(my.data, input$Selection_Chart1)
})

