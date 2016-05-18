#Tabla usos acumulados.csv was downloaded from http://datos.madrid.es/egob/catalogo/213155-3-bicimad-usos-usuarios.csv
#Preliminaries of table:
#1) From experience with datos.madrid.es, the encoding used is the csv is 'Latin-1'
#2) Upon inspection with light editor, the separator of the csv is ';'
#3) The first column is a date with format='%d/%m/%Y'
#4) Thousands are separated by dot.
#Lets read the csv, convert the first column to date format, remove the dot in the thousads separator, and plot the daily use as a function of the date

bm <- read.csv('Tabla usos acumulados.csv', sep = ';', encoding = 'Latin-1', colClasses="character")
bm[, 1] <- as.Date(bm[, 1], format='%d/%m/%Y')
bm$Usos.bicis.total <- as.numeric(gsub(".","", bm$Usos.bicis.total, fixed = TRUE))
summary(bm)

#Upon inspection of Usos.bicis.total, we find NA values. Lets eliminate them
bm <- bm[!is.na(bm$Usos.bicis.total), ]
plot(bm$DIA, bm$Usos.bicis.total)

#The previous plot shows interesting month trends. The overall use of the service increases,
#however, there are some monthly fluctuations probably related to the season.

#The evolution of the uses of bicimad can be observed nicely in the cumulative sum of the uses.
bm$cumsum <- cumsum(bm$Usos.bicis.total)
plot(bm$DIA, bm$cumsum/1000, main = "Bicimad uses up to date", xlab = 'Date', ylab = 'Cumulative use / 1000', type='l')

#Finally, personally, I do not like very much the default plots of R, thus I repeat both plots with the ggplot2 package
require(ggplot2)
ggplot(bm, aes(DIA, Usos.bicis.total)) + geom_point() +  ggtitle("Bicimad daily uses") + labs(x="Date",y="Uses")
ggplot(bm, aes(DIA, cumsum/1000)) + geom_line() +  ggtitle("Bicimad uses up to date") + labs(x="Date",y="Cumulative uses / 1000")
