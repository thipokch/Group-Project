# this is the server logic of our Shiny application

library(shiny)
library(plotly)

# defines the server for our application, sets the source for files in the scripts folder
shinyServer(function(input, output, session) {
  output$myImage <- renderImage({
    list(src = "http://d3n8a8pro7vhmx.cloudfront.net/redeemingamericaspromise/pages/453/meta_images/original/o-GRADUATION-facebook.jpg?1471243956",
         contentType = 'image/jpg',
         width = 500,
         height = 200,
         alt = "This is image alternate text")
  })
  source("scripts/library.R",  local = TRUE)$value
  source("scripts/chart1.R",  local = TRUE)$value
  source("scripts/chart2.R",  local = TRUE)$value
  source("scripts/chart3.R",  local = TRUE)$value
  
})

