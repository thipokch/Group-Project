sidebarLayout(
  sidebarPanel(
    #selectizeInput('Selection_Chart1', 'Majors', choices = NULL, multiple = TRUE)
    selectizeInput('Category.Selected', 'Majors', choices = NULL, multiple = FALSE),
    selectizeInput('Major.Selected', 'Majors', choices = NULL, multiple = TRUE)
  ),
  mainPanel(
    plotlyOutput("barChart1"),
    plotlyOutput("chart1")
  )
)
