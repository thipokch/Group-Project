#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  source("scripts/chart1.R",  local = TRUE)$value
  source("scripts/chart2.R",  local = TRUE)$value
  source("scripts/chart3.R",  local = TRUE)$value
  
})
