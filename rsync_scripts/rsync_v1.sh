#!/bin/bash

clear

echo "###################################################"
echo "#                                                 #"
echo "#  Bienvenido al sincronizador de archivos        #"
echo "#                                                 #"
echo "###################################################"

echo "Ingresar directorio o archivo de origen"
read origen

echo "Ingresar directorio o archivo de destino"
read destino

echo "¿El origen $origen es correcto? Y/N"
read respuesta

if [ $respuesta == "Y" ] || [ $respuesta == "y" ] 
then
    ori_con="y"
    echo "Origen confirmado"
else
   echo "Modificar el Origen"
   exit 0
fi

echo "¿El destino $destino es correcto? Y/N"
read respuesta

if [ $respuesta == "Y" ] || [ $respuesta == "y" ]
then
    dest_con="y"
    echo "Destino confirmado"
else
   echo "Modificar el Origen"
   exit 0
fi

if [ $ori_con == "y" ] && [ $dest_con == "y" ]
then
    echo "¿Iniciar el proceso? Y/N"
    read procesar
    if [ $procesar == "Y" ] || [ $procesar == "y" ]
    then
        clear
        rsync --progress -avz "$origen" "$destino"
    fi
else
    echo "Proceso Cancelado"
    exit 0
fi

