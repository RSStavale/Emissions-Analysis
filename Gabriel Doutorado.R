library(PerformanceAnalytics)
?chart.Correlation
chart.Correlation(scaled_median_table_filtered_shortened_columns, histogram=TRUE, pch=19, method ="spearman")
warnings()
library(factoextra)
library(FactoMineR)

##############Padroniza??o##################################################

#var.max<-apply(Dataset,2,max)
#var.min<-apply(Dataset,2,min)

#var.max
#var.min

#norm_data <- (Dataset - var.min)/(var.max - var.min)


######################PCA####################################################

res.pca.scaled.filtered <- PCA(final_map_table_macro_and_PCA[,2:21],  graph = FALSE)
list.eigen.scaled.filtered <- get_eig(res.pca.scaled.filtered)
list.eigen.scaled.filtered
res.pca.scaled.filtered$eig
fviz_screeplot(res.pca.scaled.filtered, addlabels = FALSE, ylim = c(0, 100))

var <- get_pca_var(res.pca.scaled.filtered)
contribu <- var$contrib
contribu
fviz_pca_var(res.pca.scaled.filtered, axes = c(1,2),col.var = "black")

# Colorindo as Gari?veis de controle pela contribui??o individual

fviz_pca_var(res.pca.scaled.filtered, axes = c(2,3), col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, select.var = list(contribu))

# cargas de PC1
fviz_contrib(res.pca.scaled.filtered, choice = "var", axes = 1, top = 11, xtickslab.rt = 65)
# cargas de PC2
fviz_contrib(res.pca.scaled.filtered, choice = "var", axes = 2, top = 11, xtickslab.rt = 65)
# cargas de PC3
fviz_contrib(res.pca.scaled.filtered, choice = "var", axes = 3, top = 9, xtickslab.rt = 65)

fviz_contrib(res.pca.scaled.filtered, choice="var", axes = 1,fill = "lightgray", color = "black",,top = 11) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle=65))

ind <- get_pca_ind(res.pca.scaled.filtered)
ind
ind$coord

# Usar o gradiente nas contribui??es
fviz_pca_ind(res.pca.scaled.filtered,axes = c(1, 3), col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

##Indiv?duos e vari?veis
fviz_pca_biplot(res.pca.scaled.filtered, axes = c(2, 3), repel = TRUE)

#fviz_pca_ind(res.pca.scaled.filtered, axes = c(1, 3),col.ind = "cos2",
#             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#             repel = TRUE,
#             habillage = decathlon$Competition, # color by groups
#             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
#             addEllipses = TRUE # Concentration ellipses
#             )
install.packages("stringi")

##########################Estima??o dos vetores dos PCs###################
require(Rcmdr)
PC <- 
  princomp(~Barley.Emissions..CO2eq+Cattle.Emissions..CO2eq+Chickens..broilers.Direct.emissions..CO2eq+Chickens..layers.Emissions..CO2eq+Electricity.Consumption+Electricity.Emissions..CO2eq+Energy.for.power.irrigation.Consumption+Energy.for.power.irrigation.Emissions..CO2eq+Gas.Diesel.oil.Consumption+Horses.Emissions..CO2eq+Motor.Gasoline.Consumption+Motor.Gasoline.Emissions..CO2eq+Oats.Emissions..CO2eq+Potatoes.Emissions..CO2eq+Sheep.Emissions..CO2eq+Swine..market.Indirect.emissions..CO2eq+Transport.fuel.used.in.agriculture.Consumption+Transport.fuel.used.in.agriculture.Emissions..CO2eq+Turkeys.Emissions..CO2eq+Wheat.Emissions..CO2eq,
           cor=FALSE, data=final_map_table_macro_and_PCA)
cat("\nComponent loadings:\n")
print(unclass(loadings(.PC)))
cat("\nComponent variances:\n")
print(.PC$sd^2)
cat("\n")
print(summary(.PC))
final_map_table_macro_and_PCA <<- within(final_map_table_macro_and_PCA, {
  PC3 <- .PC$scores[,3]
  PC2 <- .PC$scores[,2]
  PC1 <- .PC$scores[,1]
})