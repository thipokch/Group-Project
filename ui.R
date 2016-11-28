#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

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
            source("ui/chart1.R",  local = TRUE)$value
   ),
   tabPanel("Statistics",
            source("ui/chart2.R",  local = TRUE)$value
   ),
   tabPanel("Earning",
            source("ui/chart3.R",  local = TRUE)$value
   )
   )
)
