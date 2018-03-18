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

res.pca.scaled <- PCA(scaled_median_table,  graph = FALSE)
list.eigen.scaled <- get_eig(res.pca.scaled)
fviz_screeplot(res.pca.scaled, addlabels = TRUE, ylim = c(0, 50))

var <- get_pca_var(res.pca.scaled)
contribu <- var$contrib

fviz_pca_var(res.pca, axes=c(2,3),col.var = "black")

# Colorindo as Gari?veis de controle pela contribui??o individual

fviz_pca_var(res.pca, axes=c(1, 2), col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

# cargas de PC1
fviz_contrib(res.pca.scaled, choice = "var", axes = 2, top = 500)
# cargas de PC2
fviz_contrib(res.pca, choice = "var", axes = 2, top = 10)

ind <- get_pca_ind(res.pca)
ind
ind$coord

# Usar o gradiente nas contribui??es
fviz_pca_ind(res.pca,axes = c(1, 3), col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

##Indiv?duos e vari?veis
fviz_pca_biplot(res.pca, axes = c(2, 3), repel = TRUE)

fviz_pca_ind(res.pca, axes = c(1, 3),col.ind = "cos2",
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
