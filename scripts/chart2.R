# Builds the charts necessary for the Fact Dashboard on the final group project

library(plotly)
library(stringr)
library(dplyr)
library(tidyr)

data <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)

employment.data <- select(data, Major_category, Major, Full_time, Part_time, Full_time_year_round, Unemployed)
job.quality.data <- select(data, Major_category, Major, College_jobs, Non_college_jobs, Low_wage_jobs)



BuildJobQuality <- function(dataset, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  dataset <- dataset %>%
              filter(grepl(search, Major))
  
  # Get the list of all of the column names
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  # Split the dataset so that major and category are gone
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
    layout(title = ~paste("Job Quality for", search),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildEmployment <- function(dataset, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  dataset <- dataset %>%
              filter(grepl(search, Major))
  
  # List of all of the column names 
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  # Getting the necessary values from the dataset
  values <- c(dataset$Full_time, dataset$Part_time, dataset$Full_time_year_round, dataset$Unemployed)
  
  # Making the data frame from
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("A total of", values, "people who graduated with a degree in", search, "are", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Employment Rates for", search),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildJobQualityCategory <- function(dataset, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  category <- dataset %>%
                filter(grepl(search, Major))
  
  # Pulling the category out of the column
  category <- category$Major_category
  
  # Filtering the dataset to just data in that category
  by.category <- dataset %>%
                  filter(Major_category == category)
 
  college.jobs <- mean(by.category[["College_jobs"]])
  non.college.jobs <- mean(by.category[["Non_college_jobs"]])
  low.wage.jobs <- mean(by.category[["Low_wage_jobs"]])
  
  # Get the list of all of the column names
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  # Split the dataset so that major and category are gone
  values <- c(college.jobs, non.college.jobs, low.wage.jobs)
  # Merge the two as a long dataset using tidyr
  data <- data.frame(titles, values)
  
  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", values, "people who graduated with a degree in", category, "work", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Job Quality Averages for", category),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildEmploymentCategory <- function(dataset, search = "") {
  
  # If a specific major has been chosen it is filtered by that major
  category <- dataset %>%
                filter(grepl(search, Major))
  
  # Pulling the category out of the column
  category <- category$Major_category
  
  # Filtering the dataset to just data in that category
  by.category <- dataset %>%
                  filter(Major_category == category)
 
  full.time <- mean(by.category[["Full_time"]])
  part.time <- mean(by.category[["Part_time"]])
  full.time.year.round <- mean(by.category[["Full_time_year_round"]])
  unemployed <- mean(by.category[["Unemployed"]])
  
  # List of all of the column names 
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  # Getting the necessary values from the dataset
  values <- c(full.time, part.time, full.time.year.round, unemployed)
  
  # Making the data frame from
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", values, "people who graduated with a degree in", category, "are", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Employment Averages for", category),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

BuildTotalEmployment <- function(dataset) {
  
  full.time <- mean(dataset[["Full_time"]])
  part.time <- mean(dataset[["Part_time"]])
  full.time.year.round <- mean(dataset[["Full_time_year_round"]])
  unemployed <- mean(dataset[["Unemployed"]])
  
  # List of all of the column names 
  titles <- c("Full Time", "Part Time", "Full Time Year Round", "Unemployed")
  
  # Getting the necessary values from the dataset
  values <- c(full.time, part.time, full.time.year.round, unemployed)
  
  # Making the data frame from
  data <- data.frame(titles, values)
  
  p <- plot_ly(data = dataset, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", values, "people who were surveyed are", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
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
  
  # Get the list of all of the column names
  titles <- c("College Jobs", "Non-College Jobs", "Low Wage Jobs")
  # Split the dataset so that major and category are gone
  values <- c(college.jobs, non.college.jobs, low.wage.jobs)
  # Merge the two as a long dataset using tidyr
  data <- data.frame(titles, values)
  
  p <- plot_ly(data, labels = ~titles, values = ~values, type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste("An average of", values, "people who were surveyed work", titles),
               marker = list(line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = ~paste("Job Quality Averages for Everyone Surveyed"),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

# Renders a plotly object that returns my employment pie chart
output$pie <- renderPlotly({
  return(BuildEmployment(employment.data, input$text))
})

output$pie3 <- renderPlotly({
  return(BuildEmploymentCategory(employment.data, input$text))
})

# Renders a plotly object that returns my job quality pie chart
output$pie2 <- renderPlotly({
  return(BuildJobQuality(job.quality.data, input$text))
})

output$pie4 <- renderPlotly({
  return(BuildJobQualityCategory(job.quality.data, input$text))
})

output$pie5 <- renderPlotly({
  return(BuildTotalEmployment(employment.data))
})

output$pie4 <- renderPlotly({
  return(BuildTotalJobQuality(job.quality.data))
})