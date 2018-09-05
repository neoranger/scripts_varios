#!/bin/bash

echo "Ingresar IP a desbanear: "
read ip

sudo fail2ban-client status

echo "Ingresar jail de ip a desbanear (literal): "
read jail

echo "La jail a usar es: $jail y la ip a desbanear es: $ip. Es correcto? Y/N"
read respuesta

if [ "$respuesta" == "Y" ] || [ "$respuesta" == "y" ]; then
	sudo fail2ban-client set "$jail" unbanip "$ip"
else
	echo "Se aborta el programa"
	exit 0
fi
