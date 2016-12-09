c1.major.panel <- function(){
  fluidPage(
    selectizeInput('C1.Category.Selected', 'Major Category', choices = NULL, multiple = FALSE),
    selectizeInput('C1.Major.Selected', 'Majors', choices = NULL, multiple = FALSE)
  )
}

c3.major.panel <- function() {
  fluidPage(
    selectizeInput('C3.Category.Selected', 'Major Category', choices = NULL, multiple = FALSE),
    selectizeInput('C3.Major.Selected', 'Majors', choices = NULL, multiple = TRUE)
  )
}
