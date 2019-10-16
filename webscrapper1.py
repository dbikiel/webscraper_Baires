import re
import requests
import bs4
import sys
import pandas as pd

def extractor(dia, mes, anio, contaminante, estacion):	
	
	dia = str(dia).zfill(2)
	mes = str(mes).zfill(2)
	anio = str(anio)
	contaminante = str(contaminante)
	estacion = str(estacion)

	if contaminante == '1':
		CONT = 'CO'
	elif contaminante == '2':
		CONT = 'NO2'
	elif contaminante == '3':
		CONT = 'PM10'
	else:
		print 'BAD CONTAMINANT CHOICE'
		sys.exit()

	if estacion == '1':
		EST = 'LABOCA'
	elif estacion == '2':
		EST = 'CENTENARIO'
	elif estacion == '3':
		EST = 'CORDOBA'
	elif estacion == '4':
		EST = 'PALERMO'
	else:
		print 'BAD STATION CHOICE'
		sys.exit()
		
	filename = anio + mes + dia + '_' + EST + '_' + CONT + '.dat'
	f = open(filename,'w') 
	
	print 'PROCESANDO ' + filename + ' ...'	

	direccion = 'http://www.buenosaires.gob.ar/areas/med_ambiente/apra/calidad_amb/red_monitoreo/index.php?contaminante=' + contaminante + '&estacion=' + estacion + '&fecha_dia=' + dia + '&fecha_mes=' + mes + '&fecha_anio=' + anio

	res = requests.get(direccion)
	res.raise_for_status()

	test = bs4.BeautifulSoup(res.text)
	tabla = test.select('#grafico')

	data = test.select('img')
	
	for i in range(0, len(data)):
		tmp = str(data[i])
		m = re.search('title=',tmp)
 		if tmp[0:12] == '<img height=':
 	 		tmpSplit = tmp.split(' ')
			f.write(tmpSplit[5] + '\t')
			f.write(tmpSplit[3][7:]+ '\n')

	f.close()


########
# Genero rango de fechas desde el 1-1-2009 hasta hoy
date_rng = pd.date_range('2017/04/01', pd.to_datetime('2018/05/28'))
#date_rng = pd.date_range('2014/02/25', pd.to_datetime('2017/03/31'))

#itero para cada contaminante (1: CO, 2: NO, 3: PM10)
for cont in range(2,3):
 	#itero para cada estacion (1: la boca, 2: centenario, 3: cordoba, 4: palermo)
 	for est in range(1,4):
 		#para todas las fechas (aunque no exista la medicion...)
 		for i in date_rng:
  			extractor(str(i)[8:10], str(i)[5:7], str(i)[0:4], cont, est)

