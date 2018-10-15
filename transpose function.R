#This function fixes the columns Country and Year while grouping columns Item and Element and then transposes the Value
#over the groups

#Essa função fixa as colunas de País e Ano
#agrupa as colunas Item e Elemento
#e por fim transpõe o Valor nos grupos
my.Table.Transposing.Function <- function(table.name){
  
  idvars  <- c("country","year");
  grpvars <- c("item","element");
  outvar  <- "value";
  time    <- interaction(table.name[grpvars]);
  
  table.name <- reshape(
    cbind(table.name[c(idvars,outvar)],time),
    idvar=idvars,
    timevar="time",
    direction="wide");
  return(table.name)
}
