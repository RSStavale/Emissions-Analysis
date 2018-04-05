my.remove.duplicates.function <- function(){
  as_tibble(finalTable)
  #selects columns to drop
  toDrop <- finalTable %>% 
    select(ends_with(".x"))
  #get those columns names
  columnsNamestoDrop <- names(toDrop)
  #overwrite table without the columns
  finalTable <- finalTable %>% select(-one_of(columnsNamestoDrop))
  #selects columns to rename
  toRename <- finalTable %>% 
    select(ends_with(".y"))
  namesofcolumns <- names(finalTable)
  namesofcolumns <- str_replace_all(namesofcolumns,"\\.y$","")
  names(finalTable) <- namesofcolumns
}
