#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

source("ui/ui_library.R",  local = TRUE)$value

# Define UI for application that draws a histogram
shinyUI(navbarPage("My Major",
   tabPanel("Home",
            sidebarLayout(
              sidebarPanel(
              ),
              mainPanel(
              )
            )
   ),
   tabPanel("Popularity",
            source("ui/ui_chart1.R",  local = TRUE)$value
   ),
   tabPanel("Statistics",
            source("ui/ui_chart2.R",  local = TRUE)$value
   ),
   tabPanel("Earning",
            source("ui/ui_chart3.R",  local = TRUE)$value
   )
   )
)
