# This function takes takes in dataframe (df) and filter categories to update the selectionizedInput (out.variable)
# Default selected is pre-selected choice
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

# This function takes takes in dataframe (df) and filter majors(all) to update the selectionizedInput (out.variable)
# Default selected is pre-selected choice
text.select.major <- function(df, out.variable, default.selected) {
  major_index_list <- structure(as.list.data.frame(df$Major_code),
                                names = as.character(df$Major))
  updateSelectizeInput(session, 
                       out.variable ,
                       choices = major_index_list, 
                       selected = default.selected)
}

# This function groups category and major selectionzied input. When category is selected, majors under that
# category is automatically selected in the text.select.major.
c3.group.select.major <- function(df, default.category) {
  select.category(df,'C3.Category.Selected', default.category)
  observe({
    c3.df.filtered <- filter(df, Major_category %in% input$C3.Category.Selected)
    text.select.major(df,'C3.Major.Selected', c3.df.filtered$Major_code)
  })
}

# This function groups category and major selectionzied input. When category is selected, majors under that
# category is automatically selected in the text.select.major.
c1.group.select.major <- function(df, default.category) {
  select.category(df,'C1.Category.Selected', default.category)
  observe({
    c1.df.filtered <- filter(df, Major_category %in% input$C1.Category.Selected)
    text.select.major(df,'C1.Major.Selected', c1.df.filtered$Major_code)
  })
}