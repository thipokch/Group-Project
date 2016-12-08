# ui File for Final Group Project chart 2 (Fact Dashboard)

library(ggplot2)
library(shiny)
library(plotly)

shinyUI(fluidPage(

  titlePanel("Employment Data and Job Quality Dashboard"),
  
  sidebarPanel(
    
    selectInput("select.Major",
                label = "Choose or Search for a Major",
                choices = list(),
                selectize = TRUE
    ),
    # Description of the Dashboard
    p("For a selected major this dashboard illustrates the major's employment rates and job quality, as well as the employment rates and job quality for the discipline the major is in, and the overall rates for all of the majors in the data set."),
    p("In the employment data charts : A full time job is when the worker is employed 35+ hours a week, a full time job year round is someone employed 35+ hours a week and 50+ weeks in the year, and a part time job is employment less than 35 hours a week."),
    p("In the job quality charts : A college job is a job requiring a college degree (usually higher paying), while a non-college job does not require a college degree, and low wage jobs are usually service jobs."), 
    p("Also by hovering over a pie chart section it will also tell you the number of people that the percentage equates to!")
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

            # Average Employment and Job Quality rates for Discipline

            # Employment
            box(plotlyOutput('pie3')),

            # Job Quality
            box(plotlyOutput('pie4'))

      ),

      fluidRow(

            #E and JQ for everyone surveyed

            # Employment
            box(plotlyOutput('pie5')),

            # Job Quality
            box(plotlyOutput('pie6'))

      )
  )
))