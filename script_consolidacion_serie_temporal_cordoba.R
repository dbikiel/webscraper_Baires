library(xts)
filename1 <- '/Users/dbikiel/Documents/Programming/WebScrapper/CORDOBA/CO/SERIE_DIARIA_columna_CORDOBA_CO.dat'
data1 <- read.csv(filename1, dec = ".", stringsAsFactors = FALSE)

data1[data1 == "0"] <- NA
data1[data1 == "&lt;0.05"] <- 0.05
data1[data1 == "&lt;0.5"] <- 0.5
data1[data1 == ""] <- NA

tiempo <- strptime(data1$Time, "%Y-%m-%d %H:%M:%S")
data1$Time <- tiempo
values <- as.double(data1$CO_CORDOBA)
data1$CO_CORDOBA <- values

#Creo la serie temporal
dataserie1 <- xts(data1[,2], order.by = data1[,1])
colnames(dataserie1) <- c("CO")

filename2 <- '/Users/dbikiel/Documents/Programming/WebScrapper/CORDOBA/NO2/SERIE_DIARIA_columna_CORDOBA_NO2.dat'
data2 <- read.csv(filename2, dec = ".", stringsAsFactors = FALSE)

data2[data2 == "0"] <- NA
data2[data2 == "s/d"] <- NA
data2[data2 == ""] <- NA

tiempo <- strptime(data2$Time, "%Y-%m-%d %H:%M:%S")
data2$Time <- tiempo
values <- as.double(data2$NO2_CORDOBA)
data2$NO2_CORDOBA <- values

#Creo la serie temporal
dataserie2 <- xts(data2[,2], order.by = data2[,1])
colnames(dataserie2) <- c("NO2")

filename3 <- '/Users/dbikiel/Documents/Programming/WebScrapper/CORDOBA/PM10/SERIE_DIARIA_columna_CORDOBA_PM10.dat'
data3 <- read.csv(filename3, dec = ".", stringsAsFactors = FALSE)

data3[data3 == "0"] <- NA
data3[data3 == "&lt;0.05"] <- 0.05
data3[data3 == ""] <- NA

tiempo <- strptime(data3$Time, "%Y-%m-%d %H:%M:%S")
data3$Time <- tiempo
values <- as.double(data3$PM10_CORDOBA)
data3$PM10_CORDOBA <- values

#Creo la serie temporal
dataserie3 <- xts(data3[,2], order.by = data3[,1])
colnames(dataserie3) <- c("PM10")


dataserie_CORDOBA <- cbind(dataserie1,dataserie2,dataserie3)

#extraigo fechas y agrego horas
library(ggplot2)
CORDOBA <- ggplot(data = dataserie_CORDOBA) + geom_point(aes(x = Index, y = PM10))
CORDOBA
