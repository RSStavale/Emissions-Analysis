#Median Table contains data correlated with CO2 emissions of all sources with a moderate or plus correlation
median_table
#macro_statistics_median contains data from countries
macro_statistics_median

#summary(final_map_table_macro_and_PCA$PC1)
#final_map_table_macro_and_PCA$PC2
#final_map_table_macro_and_PCA$PC3

Human_development_index_HDI_$HDI_Average <- rowMeans(Human_development_index_HDI_[2:27],na.rm = TRUE)
summary(Human_development_index_HDI_$HDI_Average)

ICTable <- merge(x = final_map_table_macro_and_PCA, y = Human_development_index_HDI_, by = c("CountryNames"))
names(Human_development_index_HDI_)[names(Human_development_index_HDI_) == 'Country'] <- 'CountryNames'
require(Rcmdr)
median_table$CountryNames <- as.factor(median_table$CountryNames)

summary(median_table$CountryNames)
median_table$CountryNames

max(median_table$value.Total.Energy.Emissions..CO2eq...Energy.,na.rm = TRUE)

install.packages("fitdistrplus")
require(fitdistrplus)
totalEmissions <- median_table$value.Total.Energy.Emissions..CO2eq...Energy.
shapiro.test(x = totalEmissions)
fitdist(totalEmissions,distr = "")
summary(totalEmissions)
?fitdist()

ICTable$HDI_Average

scale(totalEmissions)
scaledtotalEmissions = scale(totalEmissions)
summary(totalEmissions)
ICTable$Scaled.Total.Emissions.CO2.Energy <- scale(median_table$value.Total.Energy.Emissions..CO2eq...Energy.)
ICTableModified <- merge(x = ICTable, median_table, by = c("CountryNames"))
ICTableModified$value.Total.Energy.Emissions..CO2eq...Energy. <- scale(ICTableModified$value.Total.Energy.Emissions..CO2eq...Energy.)
summary(ICTableModified$value.Total.Energy.Emissions..CO2eq...Energy.)
make.names(ICTableModified)
descdist(nonNaTotalEmissions)
descdist(nonNAPC1)
descdist(ICTableModified$HDI_Average)

fitdist(nonNAPC1, distr = "gamma")
nonNaTotalEmissions <- as.numeric(na.omit(totalEmissions))
nonNaTotalEmissions
library(tidyr)

ICTableModified$PC1
ICTableModified$HDI_Average
ICTableModified$value.Total.Energy.Emissions..CO2eq...Energy.

nonNAPC1<- as.numeric(na.omit(ICTableModified$PC1))
nonNAPC2<- as.numeric(na.omit(ICTableModified$PC2))
nonNAPC3<- as.numeric(na.omit(ICTableModified$PC3))

fitdist(ICTableModified$PC1, distr = "beta")
ICTableModifiedMinusOutlier <- ICTableModified
ICTableModifiedMinusOutlier <- ICTableModified[-c(55,76,33),]
require(Rcmdr)
ICTableModifiedMinusOutlier[55,1]

plot(ICTableModifiedMinusOutlier$GDP_Dollars_2010)

res.pca.scaled.filtered$ind$cos2
