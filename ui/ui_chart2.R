# ui File for Final Group Project chart 2 (Fact Dashboard)
# To be added to the main ui page later

library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  titlePanel("Employment Data Based on Discipline or Specific Major"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # May need to alter it so that it works properly if no major category has been chosen
#       selectInput('discipline', label = 'Major Category', choices = list("Any" = "", "Agriculture & Natural Resources" = "Agriculture & Natural Resources", "Arts" = "Arts", "Biology & Life Science" = "Biology & Life Science", "Business" = "Business", "Communications & Journalism" = "Communications & Journalism", "Computers & Mathematics" = "Computers & Mathematics", "Education" = "Education", "Engineering" = "Engineering", "Health" = "Health", "Humanities & Liberal Arts" = "Humanities & Liberal Arts", "Industrial Arts & Consumer Services" = "Industrial Arts & Consumer Services", "Interdisciplinary" = "Interdisciplinary", "Law & Public Policy" = "Law & Public Policy", "N/A (Less than a bachelors degree)" = "NA", "Physical Sciences
# " = "Physical Sciences
# ", "Psychology & Social Work
# " = "Psychology & Social Work
# ", "Social Science
# " = "Social Science
# ")),
      textInput('text', label = "Desired Major", value = "INFORMATION SCIENCES")
    ),
    
    mainPanel(
      # Employment rates (Full time vs. Part time vs. Unemployed)
      plotlyOutput('pie')
      
      # How good the jobs are (College degree necessary jobs, non - college degree, and low wage jobs)
      # plotlyOutput('pie'),
      # 
      # # Employment rates for discipline
      # plotlyOutput('pie'),
      # 
      # # Job quality of discipline
      # plotlyOutput('pie')
    )
  ) 
))