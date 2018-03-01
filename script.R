#Cria Conexao com o banco Postgre
library(RPostgreSQL)
con <- dbConnect('PostgreSQL',user = 'postgres',
                 password = 'postgres', 
                 host = 'localhost',port = 5432,
                 dbname = 'Emissions Database')
dbListTables(con)

#?dbGetQuery
#table = '"emissions_agriculture_energy"'
#col = '"Country"'
#statement =  'select * from "Emissions_Agriculture_Energy" where "Country" = Brazil'
#query = "select * from Emissions_Agriculture_Energy"
#emissions = dbGetQuery(con,'select * from emissions_agriculture_burning_crop_residues_final')
#emissions
#dim(emissions)
#?boxplot
#require(Rcmdr)

#rm(result_table)
#str(table)
#head(table)

emissions_agriculture_cultivated_organic_soils <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_cultivated_organic_soils"))
emissions_agriculture_burning_crop_residues <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_burning_crop_residues"))
emissions_agriculture_burning_savanna <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_burning_savanna"))
emissions_agriculture_crop_residues <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_crop_residues"))
emissions_agriculture_energy <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_energy"))
emissions_agriculture_enteric_fermentation <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_enteric_fermentation"))
emissions_agriculture_manure_applied_to_soils <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_manure_applied_to_soils"))
emissions_agriculture_manure_left_on_pasture <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_manure_left_on_pasture"))
emissions_agriculture_manure_management <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_manure_management"))
emissions_agriculture_rice_cultivation <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_rice_cultivation"))
emissions_agriculture_synthetic_fertilizers <- my.Table.Transposing.Function(dbReadTable(con,"emissions_agriculture_synthetic_fertilizers"))

#require(tidyverse)
#require(reshape)
#library(dplyr)

#final <- Reduce(function(x, y) merge(x, y, all=T,by("country","year"), 
 #      mylist, accumulate=F))
library(tibble)


finalTable <-  
  Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by=c("country","year"), all= TRUE),
         list(
           emissions_agriculture_manure_left_on_pasture,
           emissions_agriculture_enteric_fermentation
           #emissions_agriculture_manure_applied_to_soils,
           #emissions_agriculture_manure_management,
           #emissions_agriculture_energy,
           #emissions_agriculture_rice_cultivation,
           #emissions_agriculture_synthetic_fertilizers,
           #emissions_agriculture_cultivated_organic_soils,
           #emissions_agriculture_crop_residues,
           #emissions_agriculture_burning_savanna,
           #emissions_agriculture_burning_crop_residues
              )
   )

#turns into tibble
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

finalTable <-merge(x =  finalTable, y = emissions_agriculture_burning_crop_residues, by=c("country","year"), all= TRUE)






install.packages("ff")
require(ff)
install.packages("vegan")


median_Table <- aggregate(finalTable, by=list(finalTable$country),  FUN=median, na.rm = TRUE)
#warnings()

normalized_median_table <- normalize(median_table, method = "range", range = c(-3,3),margin = 1L, on.constant = "quiet")
normalized_median_table$year <- NULL
cor(normalized_median_table)
require(Rcmdr)
#Normalized_median_table_deconstand <- decostand(medianTable, method = "standardize", MARGIN = 1L, range.global, na.rm=TRUE)
require(tibble)
as_tibble(median_table)
as_tibble(normalized_median_table)

rm(bigcor)

#chart.Correlation(normalized_median_table[,3:1154], histogram=TRUE, pch=19)

COR <- propagate::bigcor(normalized_median_table, size = 2000,fun ="cor")
?ff
matrixFF <- as.ffdf(normalized_median_table[,3:1155])
fftempdir = "C:\\Users\\IBM_ADMIN\\Documents\\Emissions Analysis"

