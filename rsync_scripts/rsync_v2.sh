#!/bin/bash

clear

echo "###################################################"
echo "#                                                 #"
echo "#  Bienvenido al sincronizador de archivos        #"
echo "#                                                 #"
echo "###################################################"

echo "Ingresar directorio o archivo de origen"
read origen

echo "Ingresar directorio o archivo de destino (puede ser a un equipo remoto. Ejemplo: usuario@ip:/ruta/destino/)"
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

# Arranca el proceso de rsync

cancel="n"

while [ $cancel == "n" ]; do
    if [ $ori_con == "y" ] && [ $dest_con == "y" ]
    then
        echo "¿Iniciar el proceso? Y/N"
        read procesar
        if [ $procesar == "Y" ] || [ $procesar == "y" ]
        then
            clear
            rsync --progress -avz "$origen" "$destino"
            if [ $? -ne 0 ]
            then
                echo "########################################"
                echo "# Proceso de rsync terminó con errores #"
                echo "########################################"
                exit 0
            else
                echo "########################################"
                echo "# Proceso rsync terminó correctamente  #"
                echo "########################################"
                exit 0
            fi
        else
            echo "¿Desea cancelar el proceso? Y/N"
            read cancel
            if [ $cancel == "Y" ] || [ $cancel == "y" ]
            then
                echo "Proceso Cancelado"
                exit 0
            fi
        fi
    else
        echo "Proceso Cancelado. Origen o destino no existen"
        exit 0
    fi
done
