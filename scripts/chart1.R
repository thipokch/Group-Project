library(shiny)
library(dplyr)
library(plotly)

my.data <- read.csv('data/recent-grads.csv')

my.data <- my.data[,2:9]

# updateSelectizeInput(session, 'Selection_Chart1', choices = my.data$Major, selected = 'ACCOUNTING') 
group.select.major(my.data, 'Agriculture & Natural Resources')

buildBarGraph <- function(df, major) {
  
  # selected.category <- df[df$Major == major, 3]
  # df <- filter(df, Major_category == selected.category)
  df <- filter(df, Major_category %in% major)
  
  
  
  p <- plot_ly(data = df, x = ~Major, y = ~Total, name = 'Breakdown of Major Category', type = "bar")
  
  return(p)
  
}


buildPie <- function(df, major) { 
  
  #selected <- filter(df, Major == major)
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
  #buildPie(my.data, input$Selection_Chart1)
  buildPie(my.data, input$Major.Selected)
})

output$barChart1 <- renderPlotly({
  #buildBarGraph(my.data, input$Selection_Chart1)
  buildBarGraph(my.data, input$Category.Selected)
})

