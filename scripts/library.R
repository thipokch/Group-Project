df.all <- read.csv('data/all-ages.csv')

# 
# search.major(string of the output variable name, selected major code)
# i.e. search.major('C3_Major_Selected', '1100')
text.select.major <- function(out.variable, in.select) {
  major_index_list <- structure(as.list.data.frame(df.all$Major_code),
                                names = as.character(df.all$Major))
  updateSelectizeInput(session, out.variable , choices = 
                         major_index_list, selected = in.select)
}