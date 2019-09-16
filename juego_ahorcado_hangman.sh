#!/bin/bash
# Juego de ahorcado
# Natanael Garrido
# elgranpote@gmail.com
intentos=0
contador=0
version=1.2
function cabeza()
{
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                                  |._.|           |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                 |________________|"
}
function torso()
{
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                                  |._.|           |"
echo "                                                    |             |"
echo "                                                    |             |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                 |________________|"
}	
function torso_brazos()
{
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                                  |._.|           |"
echo "                                                    |             |"
echo "                                                  --|--           |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                 |________________|"
}
function piernas()
{
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                                  |._.|           |"
echo "                                                    |             |"
echo "                                                  --|--           |"
echo "                                                  __|__           |"
echo "                                                  |    |          |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                 |________________|"
}
function completo()
{
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                                 -|._.|-          |"
echo "                                                    |             |"
echo "                                                  --|--           |"
echo "                                                  __|__           |"
echo "                                                 _|    |_         |"
echo "                                                                  |"
echo "                                                                  |"
echo "                                                 |________________|"
}
cabeza
torso
torso_brazos
piernas
completo
function pause()  				# Funcion pause, ya que no existe en linux
{
read -p "$*"
}
function limpiar()
{
clear
}
limpiar
echo; echo Ahorcado v$version, Natanael Garrido.; echo
pause 'Presione una tecla para iniciar'.
declare -a palabra_user[20];
echo;
read -p "Palabra : " palabra_user2                # Se lee la palabra
let longitud=`expr length "$palabra_user2"`-1     # Sacar la longitud de la palabra:
# echo $longitud
for i in $(seq 0 $longitud);
do
palabra_user[$i]=${palabra_user2:$i:1}            # Se mete cada caracter en un subindice, en el array palabra_user[x]
# echo palabra_user[$i] = ${palabra_user[$i]}
done
read -p "Defina el numero de intentos : " intentos       # No. de intentos que puede cometer el usuario.
declare -a palabra_adivinar[$longitud];
for i in $(seq 0 $longitud);
do
palabra_adivinar[$i]=_                            # Se meten guiones en cada subindice de palabra_adivinar[x]
echo ${palabra_adivinar[$i]};
done
limpiar;
# Mostrar guiones :
while test $contador -le $intentos
do
if [ $contador -eq 1 ]
then
cabeza
elif [ $contador -eq 2 ]
then
torso
elif [ $contador -eq 3 ]
then
torso_brazos
elif [ $contador -eq 4 ]
then
piernas
elif [ $contador -ge 5 ]
then
completo
fi
echo;echo;
for i in $(seq 0 $longitud);
do
echo -n "${palabra_adivinar[$i]} ";
done
echo;
echo "Letra :                                                      Intentos: $contador de $intentos"
read letra
echo $palabra_user2 | grep "$letra" > nul 2>&1 || let contador+=1
# Busqueda secuencial : 
for i in $(seq 0 $longitud);
do
if [ ${palabra_user[$i]} = "$letra" ];then
palabra_adivinar[$i]=$letra
fi
done
echo;echo;
for i in $(seq 0 $longitud);
do
echo -n "${palabra_adivinar[$i]} ";
done
echo;echo;
limpiar
if [ "$contador" -ge "$intentos" ];
then
break
fi
i=0
cadena_final=`while test $i -le $longitud; do echo -n ${palabra_adivinar[$i]}; let i+=1; done`
if [ "$cadena_final" == "$palabra_user2" ];
then
break;
fi
done
if [ "$cadena_final" == "$palabra_user2" ];
then
echo Felicidades, has ganado.
echo "                                                         -------   "
echo "                                                    _    -yeah!-   "
echo "                                                 -|._.|- _------   "
echo "                                                    |   -          "
echo "                                                  --|--            "
echo "                                                  __|__            "
echo "                                                 _|    |_          "
echo "                                              --------------       "
echo "                                                                   "
echo "                                                                   "

echo Ahorcado v$version
echo Natanael Garrido
else
echo Lo siento, has perdido. La palabra era "$palabra_user2"
echo "                                                    ______________"
echo "                                                    |             |"
echo "                                  ------------   -|X_X|-          |"
echo "                                  - YOU LOSE -      |             |"
echo "                                  ------------    --|--           |"
echo "                                       -          __|__           |"
echo "                                       -         _|    |_         |"
echo "                                       -                          |"
echo "                                       -                          |"
echo "                                    -------      |________________|"
echo Ahorcado v$version
echo Natanael Garrido
fi
exit 0
