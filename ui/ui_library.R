
major.panel <- function(){
  fluidPage(
    selectizeInput('Category.Selected', 'Major Category', choices = NULL, multiple = FALSE),
    selectizeInput('Major.Selected', 'Majors', choices = NULL, multiple = FALSE)
  )
}

c3.major.panel <- function() {
  fluidPage(
    selectizeInput('C3.Category.Selected', 'Major Category', choices = NULL, multiple = FALSE),
    selectizeInput('C3.Major.Selected', 'Majors', choices = NULL, multiple = TRUE)
  )
}
