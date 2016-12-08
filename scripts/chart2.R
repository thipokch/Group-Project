# Builds the charts necessary for the Fact Dashboard on the final group project

library(plotly)
library(stringr)
library(dplyr)
library(tidyr)

data <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)

employment.data <- select(data, Major_category, Major, Full_time, Part_time, Full_time_year_round, Unemployed)
job.quality.data <- select(data, Major_category, Major, College_jobs, Non_college_jobs, Low_wage_jobs)

# Setting the Colors for the Pie Charts
employment.colors <- c('rgb(24,116,205)', 'rgb(178,58,238)', 'rgb(238,118,0)', 'rgb(238,44,44)')
job.quality.colors <- c('rgb(34,139,34)', 'rgb(122,103,238)', 'rgb(238,64,0)')

# Adds the list of majors to the selector
majors.list = select(data, Major)
updateSelectInput(session, "select.Major", choices = majors.list)

BuildEmployment <- function(dataset, chosen.major) {
  
  # Making sure it only filters for the exact major
  pattern <- paste0("^", chosen.major, "$")
  
  # Filtered by the chosen major
  dataset <- dataset %>%
              filter(grepl(pattern, Major))
  
  # List of all of the column names 
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  # Getting the necessary values from the dataset
  values <- c(dataset$Full_time, dataset$Part_time, dataset$Full_time_year_round, dataset$Unemployed)
  
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(values, "graduates with this major are", titles),
               marker = list(colors = employment.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Employment Rates for the Chosen Major"),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildJobQuality <- function(dataset, chosen.major) {
  
  pattern <- paste0("^", chosen.major, "$")

  dataset <- dataset %>%
              filter(grepl(pattern, Major))

  # Get the list of all of the column names
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  
  values <- c(dataset$College_jobs, dataset$Non_college_jobs, dataset$Low_wage_jobs)
  
  data <- data.frame(titles, values)

  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(values, "graduates with this major work", titles),
               marker = list(colors = job.quality.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Job Quality for the Chosen Major"),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildEmploymentCategory <- function(dataset, chosen.major) {
  
  pattern <- paste0("^", chosen.major, "$")
  
  category <- dataset %>%
                filter(grepl(pattern, Major))
  
  # Pulling the category out of the column
  category <- category$Major_category
  
  # Filtering the dataset to just data in that category
  by.category <- dataset %>%
                  filter(Major_category == category)
  
  full.time <- mean(by.category[["Full_time"]])
  part.time <- mean(by.category[["Part_time"]])
  full.time.year.round <- mean(by.category[["Full_time_year_round"]])
  unemployed <- mean(by.category[["Unemployed"]])
  
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  values <- c(full.time, part.time, full.time.year.round, unemployed)
  
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", round(values), category, "graduates are", titles),
               marker = list(colors = employment.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Employment Averages for", category),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildJobQualityCategory <- function(dataset, chosen.major) {
  
  pattern <- paste0("^", chosen.major, "$")
  
  category <- dataset %>%
                filter(grepl(pattern, Major))
  
  category <- category$Major_category
  
  by.category <- dataset %>%
                  filter(Major_category == category)
 
  college.jobs <- mean(by.category[["College_jobs"]])
  non.college.jobs <- mean(by.category[["Non_college_jobs"]])
  low.wage.jobs <- mean(by.category[["Low_wage_jobs"]])
  
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  
  values <- c(college.jobs, non.college.jobs, low.wage.jobs)
  
  data <- data.frame(titles, values)
  
  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", round(values), category, "graduates", "work", titles),
               marker = list(colors = job.quality.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Job Quality Averages for", category),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildTotalEmployment <- function(dataset) {
  
  # Getting the overall data of all of the majors
  full.time <- mean(dataset[["Full_time"]])
  part.time <- mean(dataset[["Part_time"]])
  full.time.year.round <- mean(dataset[["Full_time_year_round"]])
  unemployed <- mean(dataset[["Unemployed"]])
  
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  values <- c(full.time, part.time, full.time.year.round, unemployed)
  
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", round(values), "people surveyed are", titles),
               marker = list(colors = employment.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Employment Averages for Everyone Surveyed"),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildTotalJobQuality <- function(dataset) {
  
  college.jobs <- mean(dataset[["College_jobs"]])
  non.college.jobs <- mean(dataset[["Non_college_jobs"]])
  low.wage.jobs <- mean(dataset[["Low_wage_jobs"]])
  
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  
  values <- c(college.jobs, non.college.jobs, low.wage.jobs)
  
  data <- data.frame(titles, values)
  
  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", round(values), "people surveyed work", titles),
               marker = list(colors = job.quality.colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Job Quality Averages for Everyone Surveyed"),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

# Renders a plotly object that returns my employment pie chart
output$pie <- renderPlotly({
  return(BuildEmployment(employment.data, input$select.Major))
})

# Renders a plotly object that returns my job quality pie chart
output$pie2 <- renderPlotly({
  return(BuildJobQuality(job.quality.data, input$select.Major))
})

# Employment averages for discipline
output$pie3 <- renderPlotly({
  return(BuildEmploymentCategory(employment.data, input$select.Major))
})

# Job Quality averages for discipline
output$pie4 <- renderPlotly({
  return(BuildJobQualityCategory(job.quality.data, input$select.Major))
})

# Employment averages for all of the majors
output$pie5 <- renderPlotly({
  return(BuildTotalEmployment(employment.data))
})

# Job Quality averages for all of the majors
output$pie6 <- renderPlotly({
  return(BuildTotalJobQuality(job.quality.data))
})