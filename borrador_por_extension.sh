#!/bin/bash

echo "Ingresar la ruta donde están los archivos a borrar:"
read ruta
echo "Ingresar la extension de los archivos a ser borrados (solo la extension):"
read extension

echo "La ruta es: $ruta y la extension es .$extension. Es correcto? Y/N"
read decision

if [ -d $ruta ]
then
	if [ $decision = 'Y' ] || [ $decision = 'y' ]
	then
		cd $ruta
		for i in *.$extension; do rm -rf $i; done | echo "Archivos borrados"
	else
		echo "Nada por hacer"
	fi

else
	echo "El directorio ingresado no existe"
fi

