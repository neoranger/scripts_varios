#!/usr/bin/env bash #Tener en cuenta que si no anda puede ser tambien que el shebang sea #!/bin/bash

#Pido fecha para buscar la línea

echo -e "Introduzca la fecha a buscar (formato AAAA/MM/DD): ";
read fecha

echo "Introduzca el nombre del archivo (forma literal):";
read filename

ARCHIVO="/home/ubuntu/workspace/pruebas/${filename}"
fechadest=$(date +%Y_%m_%d)
FICHERODEST="${ARCHIVO}_${fechadest}"

#Leo el archivo y si encuentra el registro lo mueve al nuevo archivo
encontrado=0
while IFS= read -r linea; do
if [[ "${linea}" =~ ${fecha} ]]; then
encontrado=1
fi
if (( encontrado == 1 )); then
echo "${linea}" >> "${FICHERODEST}"
fi
done < ${ARCHIVO}
