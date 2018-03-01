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
require(tidyverse)
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



install.packages("tidyverse")
require(tidyverse)
require(reshape)
library(dplyr)

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

Consolidated.Emission.Table <- finalTable

boxplot(finalTable$`value.Wheat.Emissions (CO2eq) (Burning crop residues)`)

?regex
install.packages("ff")
require(ff)


finalTable[grep("Belize", finalTable$`value.Asses.Manure (N content that leaches) (Manure on pasture)`),]


medianTable <- aggregate(finalTableTest, by=list(finalTableTest$country),  FUN=median, na.rm = TRUE)
warnings()

summary(finalTable$value.Asses.Stocks)
summary(finalTable$value.Asses.Stocks.y)

#d3 <- finalTable
#summary(d3$`value.Rice, paddy.Area harvested.y`)
#summary(d3$`value.Rice, paddy.Emissions (CH4) (Rice cultivation).y`)
#summary(d3$`value.Rice, paddy.Emissions (CO2eq) (Rice cultivation).y`)
#summary(d3$`value.Rice, paddy.Implied emission factor for CH4 (Rice cultivation).y`)
#return all rows from x where there are matching values in y, keeping just columns from x.
d3 <- left_join(finalTable, emissions_agriculture_rice_cultivation, by = c("country","year"), copy = FALSE)
#install.packages("sqldf")
#library(sqldf)


# d3 <- left_join(finalTable, emissions_agriculture_rice_cultivation, by = by=c("country","year")) %>%
#   mutate(z.y = ifelse(is.na(z.y), z.x, z.y)) %>%
#   select(-z.x) %>%
#   rename(z = z.y)

require(data.table)
merged.df <- setDT(rbind(finalTable, emissions_agriculture_rice_cultivation))[, lapply(.SD, last), .(x,y)]



summary(finalTable$`value.Rice, paddy.Area harvested.x`)
finalTableTibble <- as_data_frame(finalTable)
#class(finalTableTibble)

head(finalTable$`value.Rice, paddy.Area harvested.x`)
head(finalTable$`value.Rice, paddy.Area harvested.y`)

d3 <- finalTable
require(tidyverse)
write_csv(finalTable, path = "data_output/final_table.csv")

#d3[is.na(d3$`value.Rice, paddy.Area harvested.y`),"value.Rice, paddy.Area harvested.y"] <- d3[is.na(d3$`value.Rice, paddy.Area harvested.y`),"value.Rice, paddy.Area harvested.x"]

#head(d3$`value.Rice, paddy.Area harvested.y`)

#test = tableRice %>% unite(newcol, c(item, element)) %>%
 # spread(newcol, value)
#View(test)
#View(test_reshape)
#table$id = NULL
#table$unit = NULL
