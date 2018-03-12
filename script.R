#Cria Conexao com o banco Postgre
library(RPostgreSQL)
con <- dbConnect('PostgreSQL',user = 'postgres',
                 password = 'postgres', 
                 host = 'localhost',port = 5432,
                 dbname = 'Emissions Database')
dbListTables(con)

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
#Merge de tabela individualmente
finalTable <-merge(x =  finalTable, y = emissions_agriculture_burning_crop_residues, by=c("country","year"), all= TRUE)
#---------------------------------------------------

median_Table <- aggregate(finalTable, by=list(finalTable$country),  FUN=median, na.rm = TRUE)
#warnings()
normalized_median_table <- normalize(median_table_values, method = "range", range = c(-3,3),margin = 1L, on.constant = "quiet")
#as_tibble(median_table)
as_tibble(normalized_median_table)
normalized_median_table_values <- normalized_median_table[,3:1154]
#rm(normalized_median_table)
library(dplyr)
scaled_median_table_values %>%
  mutate_all(as.double())

normalized_median_table_values <- sapply( normalized_median_table_values, as.numeric )

#cormatrix <- cor(use = "pairwise.complete.obs", x = normalized_median_table_values,method = "spearman")

require(Rcmdr)
#require(tibble)

normalized_median_table_values <- as.tibble(normalized_median_table_values)
median_table_values <- median_table[,4:1155]

scale(median_table_values)
scaled_median_table <- median_table_values

normalized_median_table <- normalize(median_table, method = "range", range = c(-3,3),margin = 1L, on.constant = "quiet")


str(scaled_median_table)
mvn(scaled_median_table, mvnTest = "royston", univariatePlot = "qqplot")

