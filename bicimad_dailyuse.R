#Tabla usos acumulados.csv was downloaded from http://datos.madrid.es/egob/catalogo/213155-3-bicimad-usos-usuarios.csv
#Preliminaries of table:
#1) From experience with datos.madrid.es, the encoding used is the csv is 'Latin-1'
#2) Upon inspection with light editor, the separator of the csv is ';'
#3) The first column is a date with format='%d/%m/%Y'
#Lets read the csv, convert the first column to date format and plot the daily use as a function of the date

bm <- read.csv('Tabla usos acumulados.csv', sep = ';', encoding = 'Latin-1')
bm[, 1] <- as.Date(bm[, 1], format='%d/%m/%Y')
summary(bm)
plot(bm$DIA, bm$Usos.bicis.total)

#From the previous plot we find that the first values do not follow the general trend and probably 
#correspond to the testing period. Thus we eliminate them. We can use the max value of the daily use that
#incidentally is the last value that does not follow the general trend.

bm <- bm[which.max(bm$Usos.bicis.total)+1:nrow(bm), ]
plot(bm$DIA, bm$Usos.bicis.total, main = "Bicimad daily uses", xlab = 'Date', ylab = 'Uses')

#The previous plot shows interesting month trends. The overall use of the service increases,
#however, there are some monthly fluctuations probably related to the season.

#The evolution of the uses of bicimad can be observed nicely in the cumulative sum of the uses.
bm$cumsum <- cumsum(bm$Usos.bicis.total)
plot(bm$DIA, bm$cumsum, main = "Bicimad uses up to date", xlab = 'Date', ylab = 'Cumulative use', type='l')

#Finally, personally, I do not like very much the default plots of R, thus I repeat both plots with the ggplot2 package
require(ggplot2)
ggplot(bm, aes(DIA, Usos.bicis.total)) + geom_point() +  ggtitle("Bicimad daily uses") + labs(x="Date",y="Uses")
ggplot(bm, aes(DIA, cumsum)) + geom_line() +  ggtitle("Bicimad uses up to date") + labs(x="Date",y="Cumulative uses")
