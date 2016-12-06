# ui File for Final Group Project chart 2 (Fact Dashboard)
# To be added to the main ui page later

library(shinydashboard)
library(ggplot2)
library(shiny)
library(plotly)

shinyUI(fluidPage(

  titlePanel("Employment Data and Job Quality Dashboard"),
  
  sidebarPanel(
    
    selectInput("select.Major",
                label = "Choose a Major",
                choices = list()
    )
    
    #textInput('text', label = "Desired Major", value = "INFORMATION SCIENCES")
  ),

  mainPanel(

      fluidRow(
  
            # Employment and Job Quaity for Major
  
            #Employment rates (Full time vs. Part time vs. Unemployed)
            box(plotlyOutput('pie')),
  
            # How good the jobs are (College degree necessary jobs, non - college degree, and low wage jobs)
            box(plotlyOutput('pie2'))
  
      ),
  
      fluidRow(
  
            # E and JQ for Category
  
            # Average Employment rates for category
            box(plotlyOutput('pie3')),
  
            # Average Job quality for category
            box(plotlyOutput('pie4'))
  
      ),
  
      fluidRow(
  
            #E and JQ for everyone surveyed
  
            # Pie charts for the averages of everyone surveyed
            box(plotlyOutput('pie5')),
  
            # Pie charts for the averages of everyone surveyed
            box(plotlyOutput('pie6'))
  
      )
  )
))
  
  # Tried to make it two rows of 3 but didn't work out

#   mainPanel(
# 
#     fluidRow(
#       column(4,
# 
#              # Employment and Job Quaity for Major
# 
#              #Employment rates (Full time vs. Part time vs. Unemployed)
#              box(plotlyOutput('pie'))
# 
# 
# 
#       ),
# 
#       column(4,
# 
#              # E and JQ for Category
# 
#              # Average Employment rates for category
#              box(plotlyOutput('pie3'))
# 
# 
# 
#       ),
# 
#       column(4,
# 
#              #E and JQ for everyone surveyed
# 
#              # Pie charts for the averages of everyone surveyed
#              box(plotlyOutput('pie5'))
# 
#       ),
# 
#       fluidRow(
# 
#         column(4,
#            # How good the jobs are (College degree necessary jobs, non - college degree, and low wage jobs)
#            box(plotlyOutput('pie2'))
#         ),
# 
#         column(4,
#            # Average Job quality for category
#            box(plotlyOutput('pie4'))
#         ),
# 
#         column(4,
#            # Pie charts for the averages of everyone surveyed
#            box(plotlyOutput('pie6'))
#          )
#       )
#     )
#   ),
# 
#   textInput('text', label = "Desired Major", value = "INFORMATION SCIENCES")
# 
# ))
