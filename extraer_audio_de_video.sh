#! /bin/bash

# Aclaración: Para poder utilizar éste script se necesita tener ffmpeg instalado en su sistema


if [ $# -ne 2 ]
then
    clear
    cat << EOF
    Error de ejecución:
    Uso: ./extraer_audio_de_video.sh <archivo.video> <archivo.audio>
EOF
 exit 0
 else
    ffmpeg -i "$1" -ab 128000 -ar 44100 "$2"
status
 fi
