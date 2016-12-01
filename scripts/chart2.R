# Builds the charts necessary for the Fact Dashboard on the final group project

library(plotly)
library(stringr)
library(dplyr)
library(tidyr)

data <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)

#employment <- c("Full Time" = select(data, Full_time), "Part Time" = select(data, Part_time), "Full Time Year Round" = select(data, Full_time_year_round), "Unemployed" = select(data, Unemployed))
#job.qualities <- c("College Jobs" = select(data, College_jobs), "Non-College Jobs" = select(data, Non_college_jobs), "Low Wage Jobs" = Low_wage_jobs)
#employment.titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
#job.quality.titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")

employment.data <- select(data, Major_category, Major, Full_time, Part_time, Full_time_year_round, Unemployed)
job.quality.data <- select(data, Major_category, Major, College_jobs, Non_college_jobs, Low_wage_jobs)



BuildJobQuality <- function(dataset, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  dataset <- dataset %>%
              filter(grepl(search, Major))
  
  # Get the list of all of the column names
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  # Split the dataset so that major and category are gone
  # dataset <- select(data, College_jobs, Non_college_jobs, Low_wage_jobs)
  values <- c(dataset$College_jobs, dataset$Non_college_jobs, dataset$Low_wage_jobs)
  # Merge the two as a long dataset using tidyr
  data <- data.frame(titles, values)
  
  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("A total of", values, "people who graduated with a degree in", search, "work", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = "Job Quality by Discipline or Specific Major",
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildEmployment <- function(data, discipline, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  dataset <- data %>%
    filter(grepl(search, Major))
  
  p <- plot_ly(data = dataset, labels = ~employment.titles, values = ~employment, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("A total of", employment, "people who graduated with a degree in", discipline, search, "are", employment.titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = "Employment by Discipline or Specific Major",
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}


# Renders a plotly object that returns my employment pie chart
# output$pie <- renderPlotly({ 
#   return(BuildEmployment(employment.data, input$discipline, input$text))
# }) 
# 
# output$pie <- renderPlotly({
#   return(BuildEmployment(employment.data, input$discipline, input$text))
# })

# Renders a plotly object that returns my job quality pie chart
output$pie <- renderPlotly({
  return(BuildJobQuality(job.quality.data, input$text))
})

# Renders a plotly object that returns my job quality pie chart
# output$pie <- renderPlotly({
#   return(BuildJobQuality(job.quality.data, input$discipline, input$text))
# })