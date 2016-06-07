#!/bin/bash

#Pido fecha para buscar la linea
echo "Introduzca la fecha a buscar (formato AAAA/MM/DD)";read FECHA

#Busco la linea pedida en el archivo y me guardo la posicion
NRO_LINEA=$(head -1 | cat ArchivoLog | grep -n "$FECHA" | cut -d':' -f1 | tail -1)
#Cuento el total de lineas del archivo
TOTAL_LINEAS=$(wc -l ArchivoLog | cut -d' ' -f1)
#Hago la diferencia del total de lineas con la linea pedida
((DIFERENCIA=TOTAL_LINEAS - NRO_LINEA))
#Guardo los datos en un nuevo archivo
ANIO=$(echo $FECHA | cut -d'/' -f1)
MES=$(echo $FECHA | cut -d'/' -f2)
DIA=$(echo $FECHA | cut -d'/' -f3)
tail -n $DIFERENCIA ArchivoLog > ArchivoLog_"$ANIO"_"$MES"_"$DIA"
