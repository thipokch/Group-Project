df.all <- read.csv('data/all-ages.csv')

select.category <- function(df, out.variable, default.selected) {
  category_index_list <- df %>%
    select(Major_category) %>%
    unique() %>%
    as.list.data.frame()
  updateSelectizeInput(session, 
                       out.variable,
                       choices = category_index_list, 
                       selected = 'Agriculture & Natural Resources')
}

text.select.major <- function(df, out.variable, default.selected) {
  major_index_list <- structure(as.list.data.frame(df$Major_code),
                                names = as.character(df$Major))
  updateSelectizeInput(session, 
                       out.variable ,
                       choices = major_index_list, 
                       selected = default.selected)
}

group.select.major <- function(df, default.category) {
  df <- df.all
  select.category(df,'Category.Selected', default.category)
  
  observe({
    df.filtered <- filter(df, Major_category %in% input$Category.Selected)
    text.select.major(df,'Major.Selected', df.filtered$Major_code)
  })
}
