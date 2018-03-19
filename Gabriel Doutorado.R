library(PerformanceAnalytics)
?chart.Correlation
chart.Correlation(scaled_median_table, histogram=TRUE, pch=19, method ="spearman")
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

res.pca.scaled.filtered <- PCA(scaled_median_table_filtered_0_5_renamed_columns,  graph = FALSE)
list.eigen.scaled.filtered <- get_eig(res.pca.scaled.filtered)
list.eigen.scaled.filtered

fviz_screeplot(res.pca.scaled.filtered, addlabels = FALSE, ylim = c(0, 100))

var <- get_pca_var(res.pca.scaled.filtered)
contribu <- var$contrib
contribu
fviz_pca_var(res.pca.scaled.filtered, axes = c(1,2),col.var = "black")
?fviz_pca_var()

# Colorindo as Gari?veis de controle pela contribui??o individual

fviz_pca_var(res.pca.scaled.filtered, axes = c(1,5), col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, select.var = list(contribu))

# cargas de PC1
fviz_contrib(res.pca.scaled.filtered, choice = "var", axes = 1, top = 500)
# cargas de PC2
fviz_contrib(res.pca, choice = "var", axes = 2, top = 10)

ind <- get_pca_ind(res.pca.scaled.filtered)
ind
ind$coord

# Usar o gradiente nas contribui??es
fviz_pca_ind(res.pca.scaled.filtered,axes = c(1, 3), col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

##Indiv?duos e vari?veis
fviz_pca_biplot(res.pca.scaled.filtered, axes = c(2, 3), repel = TRUE)

fviz_pca_ind(res.pca.scaled.filtered, axes = c(1, 3),col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE,
             habillage = decathlon$Competition, # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE # Concentration ellipses
             )


##########################Estima??o dos vetores dos PCs###################

PC <- 
  princomp(~Discus+High.jump+Javeline+Long.jump+Points+Pole.vault+Rank+Shot.put+X100m+X110m.hurdle+X400m+X1500m,
   cor=TRUE, data=decathlon)
  cat("\nComponent loadings:\n")
  print(unclass(loadings(PC)))
  cat("\nComponent variances:\n")
  print(PC$sd^2)
  cat("\n")
  print(summary(PC))
  decathlon <<- within(decathlon, {
    PC4 <- PC$scores[,4]
    PC3 <- PC$scores[,3]
    PC2 <- PC$scores[,2]
    PC1 <- PC$scores[,1]
})
