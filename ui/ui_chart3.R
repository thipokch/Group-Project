verticalLayout(
  plotlyOutput("chart3"),
  wellPanel(
    selectizeInput('C3.major.selected', 'Majors', choices = NULL, multiple = TRUE)
  )
)
