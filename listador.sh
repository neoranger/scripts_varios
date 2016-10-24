#!/bin/bash
echo "Ingrese el directorio a listar"
read directorio

if [ -d $directorio ]; then
	echo "es un directorio"
	#ls -R $directorio
	#tree $directorio
	tree -d $directorio
else
	echo "no es un directorio"
fi
