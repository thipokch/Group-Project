# ui File for Final Group Project chart 2 (Fact Dashboard)
# To be added to the main ui page later

library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  titlePanel("Employment Data Based on Discipline or Specific Major"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      textInput('text', label = "Desired Major", value = "INFORMATION SCIENCES")
    ),
    
    mainPanel(
      # Employment rates (Full time vs. Part time vs. Unemployed)
      plotlyOutput('pie'),
      
      # How good the jobs are (College degree necessary jobs, non - college degree, and low wage jobs)
      plotlyOutput('pie2'),

      # Average Employment rates for category
      plotlyOutput('pie3'),

      # Average Job quality for category
      plotlyOutput('pie4'),
      
      # Pie charts for the averages of everyone surveyed
      plotlyOutput('pie5'),
      plotlyOutput('pie6')
    )
  ) 
))