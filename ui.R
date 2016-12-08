# this creates the user-interface of our Shiny application

library(shiny)
library(plotly)

# sets the source of the UI for individual pages
source("ui/ui_library.R",  local = TRUE)$value

# defines UI for our application, creates four tab panels
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
   tabPanel("Employment",
            source("ui/ui_chart2.R",  local = TRUE)$value
   ),
   tabPanel("Earning",
            source("ui/ui_chart3.R",  local = TRUE)$value
   )
   )
)
