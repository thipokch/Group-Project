verticalLayout(
  plotlyOutput("chart3"),
  wellPanel(
    selectizeInput('Category.Selected', 'Majors', choices = NULL, multiple = FALSE),
    selectizeInput('Major.Selected', 'Majors', choices = NULL, multiple = TRUE)
  )
)
