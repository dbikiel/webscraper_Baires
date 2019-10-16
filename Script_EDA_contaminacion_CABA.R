filename <- '/Users/dbikiel/Documents/Programming/WebScrapper/LABOCA/CO/SERIE_DIARIA_LABOCA_CO.dat'
data <- read.csv(filename, dec = ".", stringsAsFactors = FALSE)

colnames(data) <- c('Dia', paste(seq(13,24),c('hs')), paste(seq(1,12),c('hs')))
data[data == "0"] <- NA
data[data == "&lt;0.05"] <- 0.05
data[data == ""] <- NA

data$Dia <- as.Date(as.character(data$Dia), format = "%Y%m%d")
for(i in 2:25){
        data[,i] <- as.double(data[,i])
}

library(ggplot2)

#Calculo la mediana de los valores por dia
data_median <- apply(data[,2:25],1, median, na.rm = TRUE) 
data_mean <- rowMeans(data[,2:25], na.rm = TRUE)

data$Median <- data_median
data$Mean <- data_mean
data$anio <- format(data$Dia, "%Y")
data$mes <- format(data$Dia, "%m")
data$dia <- format(data$Dia, "%d")
data$diaSemana <- weekdays(data$Dia)

LABOCA_CO <- ggplot(data = data) + geom_point(aes(x = Dia, y = data_median))
LABOCA_CO
