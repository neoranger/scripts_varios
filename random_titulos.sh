#!/bin/bash

# Este script está creado para tomar una lista y sacar al azar una linea
# Script creado para el grupo Club de Podcasting en Telegram: https://t.me/clubdepodcasting

# USO: Crear archivo lista_principal.txt el cual llevará el nombre del podcast (uno por linea).
# No dejar la última linea en blanco porque sino el script la toma como opción disponible.
# El script generará un archivo de salida con la linea elegida de la lista principal y borrará esa linea del archivo original.

if [ -s lista_principal.txt ]; then
	elegido=`sed -n $((RANDOM % $(cat lista_principal.txt | wc -l) + 1))p lista_principal.txt`
	echo "$elegido" >> podcasts_elegidos.txt

	echo "##############################################################################################"
	echo "# El Podcast elegido fue: $elegido. Se guardó el nombre en el archivo podcasts_elegidos.txt #"
	echo "##############################################################################################"

	sed -i /"$elegido"/d lista_principal.txt

else
   echo "El archivo lista_principal.txt no existe o está vacío"
fi
exit 0
