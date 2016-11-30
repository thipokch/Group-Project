library(shiny)
library(dplyr)
library(plotly)

my.data <- read.csv('data/recent-grads.csv', stringsAsFactors = FALSE)

my.data <- my.data[,2:9]

group.select.major(my.data, 'Agriculture & Natural Resources')

buildBarGraph <- function(df, major) {

  selected.category <- filter(df, Major_code %in% major) %>%
                    select(Major_category)
  df <- filter(df, Major_category %in% selected.category)


  num_majors <- nrow(df)
  colors <- vector(mode = "character", length = num_majors)
  colors[1:num_majors] <- 'rgb(128,133,133)'
  colors[match(major, df$Major_code)] <- 'rgb(144,103,167)' #purple

  p <- plot_ly(data = df, x = ~Major, y = ~Total, name = 'Breakdown of Major Category', type = "bar",
               marker = list(color = colors)) %>%
        layout(title = 'Breakdown of Major Category', xaxis = list(showticklabels = FALSE),
               yaxis = list(title = "Total Graduates"), autosize = FALSE, width = 600, height = 400)

  return(p)

}


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
          layout(title = 'Breakdown of Graduates by Gender',
            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

  return(p)

}


output$chart1 <- renderPlotly({
  buildPie(my.data, input$Major.Selected)
})

output$barChart1 <- renderPlotly({
  buildBarGraph(my.data, input$Major.Selected)
})

