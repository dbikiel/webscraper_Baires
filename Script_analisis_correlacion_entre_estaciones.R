source('~/Dropbox (Personal)/Contaminacion Buenos Aires/script_consolidacion_serie_temporal_laboca.R')
source('~/Dropbox (Personal)/Contaminacion Buenos Aires/script_consolidacion_serie_temporal_cordoba.R')
source('~/Dropbox (Personal)/Contaminacion Buenos Aires/script_consolidacion_serie_temporal_centenario.R')
source('~/Dropbox (Personal)/Contaminacion Buenos Aires/script_consolidacion_serie_temporal_palermo.R')

#EVALUO CORRELACION ENTRE VARIABLES MEDIDAS POR ESTACION
#LA BOCA

#Correlacion CO y NO2
laboca <- na.omit(dataserie_LABOCA)
laboca.lm <- lm( CO ~ NO2, data = as.data.frame(laboca))
plot(coredata(laboca$CO), coredata(laboca$NO2))
summary(laboca.lm)

#elimino los datos de CO mayores a 30
laboca$CO[laboca$CO > 30] <- NA
laboca <- na.omit(laboca)
laboca.lm <- lm( CO ~ NO2, data = as.data.frame(laboca))
plot(coredata(laboca$CO), coredata(laboca$NO2))
summary(laboca.lm)

#Correlacion CO y PM10
laboca <- na.omit(dataserie_LABOCA)
laboca.lm <- lm( CO ~ PM10, data = as.data.frame(laboca))
plot(coredata(laboca$CO), coredata(laboca$PM10))
summary(laboca.lm)

#elimino los datos de CO mayores a 30
laboca$CO[laboca$CO > 30] <- NA
laboca <- na.omit(laboca)
laboca.lm <- lm( CO ~ PM10, data = as.data.frame(laboca))
plot(coredata(laboca$CO), coredata(laboca$PM10))
summary(laboca.lm)

#Agregacion temporal
library(zoo)
dataserie_LABOCA_daily <- aggregate(dataserie_LABOCA, as.Date, median, na.rm = TRUE)
dataserie_LABOCA_monthly <- aggregate(dataserie_LABOCA, as.yearmon, median, na.rm = TRUE)

#EVALUO CORRELACION ENTRE ESTACIONES
dataserie_CO <- cbind(dataserie_LABOCA,dataserie_CENTENARIO,dataserie_CORDOBA)
dataserie_CO$NO2 <- NULL
dataserie_CO$NO2.1 <- NULL
dataserie_CO$NO2.2 <- NULL
dataserie_CO$PM10 <- NULL
dataserie_CO$PM10.1 <- NULL
dataserie_CO$PM10.2 <- NULL
colnames(dataserie_CO) <- c("LABOCA", "CENTENARIO", "CORDOBA")

dataserie_NO2 <- cbind(dataserie_LABOCA,dataserie_CENTENARIO,dataserie_CORDOBA)
dataserie_NO2$CO <- NULL
dataserie_NO2$CO.1 <- NULL
dataserie_NO2$CO.2 <- NULL
dataserie_NO2$PM10 <- NULL
dataserie_NO2$PM10.1 <- NULL
dataserie_NO2$PM10.2 <- NULL
colnames(dataserie_NO2) <- c("LABOCA", "CENTENARIO", "CORDOBA")

dataserie_PM10 <- cbind(dataserie_LABOCA,dataserie_CENTENARIO,dataserie_CORDOBA)
dataserie_PM10$NO2 <- NULL
dataserie_PM10$NO2.1 <- NULL
dataserie_PM10$NO2.2 <- NULL
dataserie_PM10$CO <- NULL
dataserie_PM10$CO.1 <- NULL
dataserie_PM10$CO.2 <- NULL
colnames(dataserie_PM10) <- c("LABOCA", "CENTENARIO", "CORDOBA")

dataserie_CO_daily <- aggregate(dataserie_CO, as.Date, median, na.rm = TRUE)
dataserie_NO2_daily <- aggregate(dataserie_NO2, as.Date, median, na.rm = TRUE)
dataserie_PM10_daily <- aggregate(dataserie_PM10, as.Date, median, na.rm = TRUE)

cor(dataserie_CO_daily, use = "pairwise.complete.obs")
cor(dataserie_NO2_daily, use = "pairwise.complete.obs")
cor(dataserie_PM10_daily, use = "pairwise.complete.obs")

plot(dataserie_PM10_daily, screens = 1)

