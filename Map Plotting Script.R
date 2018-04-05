install.packages("rworldmap")

require(rworldmap)

cor(final_map_table_macro_and_PCA[,c("GDP_Dollars_2010","PC1","PC2","PC3")],
    method="spearman", use="complete")

maptest <- joinCountryData2Map(
  final_map_table_macro_and_PCA,
                  joinCode = "NAME",
                  nameJoinColumn = "CountryNames",
                  verbose = TRUE)

PC1Map <- mapCountryData( maptest, nameColumnToPlot="PC1", 
                          colourPalette = "heat",catMethod = "pretty",
                          mapTitle = "Energia/Transporte")
PC2Map <- mapCountryData( maptest, nameColumnToPlot="PC2" , 
                          colourPalette = "heat",catMethod = "pretty",
                          mapTitle = "Energia/Irrigação")
PC3Map <- mapCountryData( maptest, nameColumnToPlot="PC3" ,  
                          catMethod  ="pretty",
                          colourPalette = "heat",
                          mapTitle = "Energia x Eficiência")
                          
getMap()
PC1Map
GDPMap <- mapBubbles(maptest,nameColumnToPlot = "GDP_Dollars_2010", 
                     nameZSize = "GDP_Dollars_2010", mapRegion = "eurasia", 
                     landCol = "wheat",
                     oceanCol = "lightblue")
maptest$GDP_Dollars_2010
#names(final_map_table_macro_and_PCA)[names(final_map_table_macro_and_PCA) == 'value.Gross Domestic Product.Value US$, 2010 prices'] <- 'GDP_Dollars_2010'
#?mapBubbles
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
as.integer(final_map_table_macro_and_PCA$GDP_Dollars_2010)
mapBubbles(df = PC1Map, nameZSize="POP_EST", catMethod = "pretty")

             