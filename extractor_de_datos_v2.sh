#!/usr/bin/env bash

#Pido fecha para buscar la línea

echo -e "Introduzca la fecha a buscar (formato AAAA/MM/DD): ";
read fecha

ARCHIVO='/home/neoranger/Documentos/git/scripts_varios/ArchivoLog'
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