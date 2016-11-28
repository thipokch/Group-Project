sidebarLayout(
  sidebarPanel(
    selectizeInput('C3_Major_Selected', 'Majors', choices = NULL, multiple = TRUE)
  ),
  mainPanel(
    renderPlot({
      distributionGraph(input$df, input)
    })
  )
)
