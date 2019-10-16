import os
import pandas as pd

#Consolida los archivos de la estacion EST y el contaminante CONT:
CONT = 'PM10'
EST = 'PALERMO'

os.chdir('/Users/dbikiel/Documents/Programming/WebScrapper/' + EST + '/' + CONT +'/')

ENDING = '_' + EST + '_' + CONT + '.dat'

datos = {}

for filename in os.listdir(os.getcwd()):
	if filename[8:] == ENDING:
		statinfo = os.stat(filename)
		if statinfo.st_size == 0:
			datos[filename[0:8]] = ['NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA']
		else:
			f = open(filename,'r')
			tmp = []
			for i in f.readlines():
				k = i.split('\t')
# 				if k == '&lt;0.05':
# 					k = '<0.05'
				tmp.append(k[1].rstrip('\n'))
			
			datos[filename[0:8]] = tmp
			f.close()

OUTPUT = 'SERIE_DIARIA_columna' + ENDING

#f = open(OUTPUT,'w')

#D = pd.DataFrame.from_dict(datos, orient = 'index')
#D.columns = ['13','14','15','16','17','18','19','20','21','22','23','24','01','02','03','04','05','06','07','08','09','10','11','12']

#D = D.sort_index()
#D.index.name = 'DIA'
#print D

#D.to_csv(OUTPUT, na_rep = '0', header = True, index = True)

#GENERO SERIE
import datetime 
fechas = datos.keys()
fechas.sort()

START = fechas[0]
END = fechas[-1]

d0 = datetime.datetime(int(START[0:4]),int(START[4:6]),int(START[6:8]))
d1 = datetime.datetime(int(END[0:4]),int(END[4:6]),int(END[6:8]))
delta = d1 - d0
delta = delta.days + 1

START = d0 + pd.Timedelta('-11 hours')
END = d1 + pd.Timedelta('12 hours')

serie_fechas = [START]
for i in range(0,delta):
        for j in range(0,24):
                tmp = serie_fechas[-1]+ pd.Timedelta('1 hours')
                serie_fechas.append(tmp)

serie_fechas.pop()


datosDict = {}
n = 0
for i in fechas:
	for j in datos[i]: 
		datosDict[serie_fechas[n]] = j 
		n = n + 1 

D = pd.DataFrame.from_dict(datosDict, orient='index')
D.columns = [CONT + '_' + EST]
D.index.name = 'Time'
D = D.sort_index()
print D

D.to_csv(OUTPUT, na_rep = 'NA', header = True, index = True)
	
