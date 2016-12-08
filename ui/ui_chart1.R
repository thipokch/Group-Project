# this creates the user-interface for the popularity tab in our application

sidebarLayout(
  
  # adds a select input for major category and major on the sidebar panel
  sidebarPanel(
    major.panel(),
    p("This dashboard displays information about the popularity of a major within a specified category.
      The data was taken from recent graduates, individuals younger than 28."),
    p("To view the popularity and breakdown by gender, select a major category and major.")
  ),
  # adds text and charts to be displayed on the main panel
  mainPanel(
    h3("Popularity"),
    br(),
    plotlyOutput("barChart1"),
    br(),
    br(),
    br(),
    br(),
    plotlyOutput("chart1")
  )
)
