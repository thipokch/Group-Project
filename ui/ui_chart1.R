sidebarLayout(
  sidebarPanel(
    selectizeInput('Selection_Chart1', 'Majors', choices = NULL, multiple = TRUE)
  ),
  mainPanel(
    plotlyOutput("barChart1"),
    plotlyOutput("chart1")
  )
)
