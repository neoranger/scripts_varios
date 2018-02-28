#!/bin/bash
clear
echo " *** SCRIPT PARA EL APAGADO DEL EQUIPO *** "
echo " SELECCIONA UNA OPCIÓN:"
echo " 1.-Apagar equipo ahora"
echo " 2.-Reiniciar equipo ahora"
echo " 3.-Asignar hora de apagado del equipo"
echo " 4.-Asignar hora de reinicio del equipo"
echo " 5.-Apagar equipo a los xx minutos"
echo " 6.-Reiniciar equipo a los xx minutos"
echo " 7.-Cancelar apagado/reinicio activo "
echo " 0.-Salir"
echo ""
read -p "OPCIÓN: " OPCION
case $OPCION in
1) sudo shutdown -h now;;
2) sudo shutdown -r now;;
3) echo -n " ¿ A qué hora ?(HH:MM): "
read hora
sudo shutdown -h $hora;;
4) echo -n " ¿ A qué hora ?(HH:MM): "
read hora
sudo shutdown -r $hora;;
5)echo -n " ¿ En cuántos minutos se apagará el equipo?: "
read minutos
sudo shutdown -h $minutos;;
6)echo -n " ¿ En cuántos minutos se reiniciará el equipo?: "
read minutos
sudo shutdown -r $minutos;;
7) sudo shutdown -c;;
0) exit;;
*) echo " OPCIÓN NO VÁLIDA "
exit 1;;
esac
exit 0
