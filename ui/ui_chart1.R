sidebarLayout(
  sidebarPanel(
    selectizeInput('Selection_Chart1', 'Majors', choices = NULL, multiple = TRUE)
  ),
  mainPanel(
    plotlyOutput("chart1")
  )
)
