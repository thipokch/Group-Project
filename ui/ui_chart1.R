sidebarLayout(
  sidebarPanel(
    #selectizeInput('Selection_Chart1', 'Majors', choices = NULL, multiple = TRUE)
    major.panel()
  ),
  mainPanel(
    h3("Popularity"),
    p("Data taken from the recent graduates dataset"),
    br(),
    plotlyOutput("barChart1"),
    br(),
    br(),
    br(),
    h4("Gender Breakdown"),
    br(),
    br(),
    plotlyOutput("chart1")
  )
)
