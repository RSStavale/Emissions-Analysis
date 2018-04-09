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
                          colourPalette = "diverging",catMethod = "pretty",
#one of "heat", "diverging", "white2Black", "black2White", 
#"topo", "rainbow", "terrain", "negpos8", "negpos9"
                          numCats = 500,
                          mapTitle = "Energia/Transporte")
PC2Map <- mapCountryData( maptest, nameColumnToPlot="PC2" , 
                          colourPalette = "diverging",catMethod = "pretty",
                          numCats = 500,
                          add = FALSE,
                          mapTitle = "Energia/Irrigação")
PC3Map <- mapCountryData( maptest, nameColumnToPlot="PC3" ,
                          catMethod  ="pretty",
                          colourPalette = "diverging",
                          numCats = 500,
                          mapTitle = "Energia/Eficiência")
#final_map_table_macro_and_PCA$CountryNames[final_map_table_macro_and_PCA$CountryNames=="China, mainland"] <- "China"

GDPMap <- mapBubbles(maptest,nameColumnToPlot = "GDP_Dollars_2010", 
                     nameZSize = "GDP_Dollars_2010",
                     nameZColour = "GDP_Dollars_2010",
                    colourPalette = "heat",
                    numCats = 5,
                     add = TRUE,
                     symbolSize = 0.5,
                     #nameZColour = "GDP_Dollars_2010",
                     catMethod = "pretty"
                     ,legendPos = "topright",addColourLegend = FALSE)
maptest$GDP_Dollars_2010
#require(Rcmdr)
#?mapBubbles
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
as.integer(final_map_table_macro_and_PCA$GDP_Dollars_2010)
mapBubbles(df = PC1Map, nameZSize="POP_EST", catMethod = "pretty")