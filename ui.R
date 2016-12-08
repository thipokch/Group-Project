# this creates the user-interface of our Shiny application

library(shiny)
library(plotly)

# sets the source of the UI for individual pages
source("ui/ui_library.R",  local = TRUE)$value

# defines UI for our application, creates four tab panels
shinyUI(navbarPage("College Major Guide",
   tabPanel("Home",
            sidebarLayout(
              sidebarPanel(
              ),
              mainPanel(
              h3("Guide to Choosing a College Major"),
              p("Our team worked with the college majors dataset from FiveThirtyEight. Specifically this data was
              obtained from the American Community Survey 2010-2012 Public Use Microdata Series."),
              p("The link to the data is here : http://www.census.gov/acs/www/data_documentation/pums_data/"),
              p("This application was created for prospective college students and those already in college 
                trying to decide on a major. It contains information about popularity, employment rates,
                job quality, and earnings for 173 different majors."),
              p("Hope you find our application helpful!"),
              p("- Anna Maglio, Dylan Desmond, Thipok Cholsaipant")
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
