# this is the server logic of our Shiny application

library(shiny)
library(plotly)

# defines the server for our application, sets the source for files in the scripts folder
shinyServer(function(input, output, session) {
  source("scripts/library.R",  local = TRUE)$value
  source("scripts/chart1.R",  local = TRUE)$value
  source("scripts/chart2.R",  local = TRUE)$value
  source("scripts/chart3.R",  local = TRUE)$value
  
})

