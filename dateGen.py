import pandas as pd

dateRange = pd.date_range("2008-12-31 13:00:00", "2008-12-31 14:00:00", freq = "H")
print dateRange

serie_fechas = [dateRange[0]]
for i in range(0,3027):
	for j in range(0,24):
		tmp = serie_fechas[-1]+ pd.Timedelta('1 hours')
		serie_fechas.append(tmp)

serie_fechas.pop()
print serie_fechas[0], serie_fechas[-1]
print len(serie_fechas)
	


