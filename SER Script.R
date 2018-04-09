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

finalTable <-  
  Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by=c("country","year"), all= TRUE),
         list(
           emissions_agriculture_manure_left_on_pasture,
           emissions_agriculture_enteric_fermentation
         )
  )

#turns into tibble
require(tibble)
#Executa função customizada de remoção de variáveis redundantes.
#Por causa da natureza d função Reduce(merge() all= TRUE) que duplica variáveis com mesmo nome 
#é desnecessário manter as duas, logo é retirada uma delas e renomeada o sufixo da que se deseja manter
#no caso a tabela do primeiro argumento.
my.remove.duplicates.function()


#Merge de tabela individualmente
#emissions_agriculture_manure_applied_to_soils,
#emissions_agriculture_manure_management,
#emissions_agriculture_energy,
#emissions_agriculture_rice_cultivation,
#emissions_agriculture_synthetic_fertilizers,
#emissions_agriculture_cultivated_organic_soils,
#emissions_agriculture_crop_residues,
#emissions_agriculture_burning_savanna,
#emissions_agriculture_burning_crop_residues
#Essas duas linhas de código devem ser executadas repetidamente pra cada dataframe
finalTable <-merge(x =  finalTable, y = emissions_agriculture_burning_crop_residues, by=c("country","year"), all= TRUE)
my.remove.duplicates.function()
#------------------------------------------------------------------------------------------------------------
#Função que executa agregação por mediana, renomeia a primeira coluna agrupada e remove as duas seguidas.
median_table <- aggregate(finalTable, by=list(finalTable$country),  FUN=median, na.rm = TRUE)
colnames(median_table)[1] <- "CountryNames"
median_table$country <- NULL
median_table$year <- NULL

#
#final_map_table_macro_and_PCA = left_join(scaled_median_table_filtered_shortened_columns, macro_statistics_median , by = "CountryNames")
#names(final_map_table_macro_and_PCA)[names(final_map_table_macro_and_PCA) == 'value.Gross.Domestic.Product.Value.US...2010.prices'] <- 'GDP_Dollars_2010'

#------------------------------------------------------------------------------------------------------------

require(rworldmap)

mappingCountries <- joinCountryData2Map(
  median_table,
  joinCode = "NAME",
  nameJoinColumn = "CountryNames",
  verbose = TRUE)
summary(median_table$`value.All Animals.Emissions (CO2eq) (Manure on pasture)`)
Map1 <- mapCountryData( mappingCountries, nameColumnToPlot="value.All Animals.Emissions (CO2eq) (Enteric)", 
                            colourPalette = "heat", catMethod = "pretty",numCats = 20
                        ,mapTitle = "")
# "heat", "diverging", "white2Black", "black2White", "topo", "rainbow", "terrain", "negpos8", "negpos9"

names(SER_final_table) <- make.names(names(SER_final_table))
cor(SER_final_table[,c("All.Animals.Emissions.CO2eq",
                       "GDP.Dollars.2010")], method="spearman",
    use="complete")


SER_final_table$All.Animals.Emissions.CO2eq

GDPMap <- mapBubbles(maptest,nameColumnToPlot = "GDP_Dollars_2010", 
                     nameZSize = "GDP_Dollars_2010", mapRegion = "world",
                     add = TRUE,
                     symbolSize = 0.5,colourPalette = "rainbow",
                     #nameZColour = "GDP_Dollars_2010",
                     catMethod = "pretty",legendPos = "topright")
require(dplyr)
SER_final_table = left_join(median_table, macro_statistics_median , by = "CountryNames")
names(SER_final_table)[names(SER_final_table) == 'value.Gross.Domestic.Product.Value.US...2010.prices'] <- 'GDP.Dollars.2010'
SER_final_table$`value.Gross Domestic Product.Value US$, 2010 prices`


shapiro.test(SER_final_table$All.Animals.Emissions.CO2eq)
