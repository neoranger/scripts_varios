#!/bin/bash

# Script para desbloquear IPs de una manera fácil.
# Funciona si estás usando fail2ban en tu servidor.
# Mas info: https://neositelinux.com/desbloquear-ip-con-fail2ban

echo "Conoce la IP a desbloquear? Y/N"
read respuesta1 
if [ -z $respuesta1 ]; then
    echo "Respuesta erronea o vacía. Se aborta el programa"
    exit 0
fi

if [ "$respuesta1" == "Y" ] || [ "$respuesta1" == "y" ]; then
    echo "Ingresar IP a desbanear: "
    read ip
    if [ -z $respuesta1 ]; then
        echo "Respuesta erronea o vacía. Se aborta el programa"
    exit 0
fi

else
     sudo iptables -L -n
     echo "----------------------------------------------------------"
     echo "Ingresar IP a desbanear: "
     read ip
fi

echo "----------------------------------------------------------"

echo "Conoce la celda? Y/N"
read respuesta2

if [ -z $respuesta2 ]; then
    echo "Respuesta erronea o vacía. Se aborta el programa"
    exit 0
fi

if [ "$respuesta2" == "Y" ] || [ "$respuesta2" == "y" ]; then
    echo "Ingresar nombre de celda: "
    read jail
else
    sudo fail2ban-client status
    echo "----------------------------------------------------------"
    echo "Ingresar nombre de celda: "
    read jail
fi

echo "----------------------------------------------------------"

echo "La jail a usar es: $jail y la ip a desbanear es: $ip. Es correcto? Y/N"
read respuesta3

if [ -z $respuesta3 ]; then
    echo "Respuesta erronea. Se aborta el programa"
    exit 0
fi

if [ "$respuesta3" == "Y" ] || [ "$respuesta3" == "y" ]; then
    sudo fail2ban-client set "$jail" unbanip "$ip"
else
    echo "Se cancela el programa"
    exit 0
fi
