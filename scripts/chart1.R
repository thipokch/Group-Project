library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)

my.data <- read.csv('data/recent-grads.csv')

by.major <- my.data[,2:9]

text.select.major('Selection_Chart1', '1100')

buildPie <- function(df, major) { 
  
  selected <- filter(df, Major_code %in% major)
  
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
  buildPie(by.major, input$Selection_Chart1)
})

