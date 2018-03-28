install.packages("rworldmap")

require(rworldmap)



maptest <- joinCountryData2Map(
  final_map_table_macro_and_PCA,
                  joinCode = "NAME",
                  nameJoinColumn = "CountryNames",
                  verbose = TRUE)


PC1Map <- mapCountryData( maptest, nameColumnToPlot="PC1" )
PC2Map <- mapCountryData( maptest, nameColumnToPlot="PC2" )
PC3Map <- mapCountryData( maptest, nameColumnToPlot="PC3" )
#GDPMap <- mapCountryData(maptest,nameColumnToPlot = "GDP_Dollars_2010")

#names(final_map_table_macro_and_PCA)[names(final_map_table_macro_and_PCA) == 'value.Gross Domestic Product.Value US$, 2010 prices'] <- 'GDP_Dollars_2010'
#?mapBubbles

# mapBubbles(df = PC1Map,
#            nameZSize = "GDP_Dollars_2010",
#            #nameZColour = "GDP_Dollars_2010",
#            oceanCol = 'lightblue',
#            landCol = 'wheat'
#            )
