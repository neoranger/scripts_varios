#!/bin/bash
selection=
until [ "$selection" = "0" ]; do
    clear
    echo "Reproducir sonido:"
    echo ""
    echo "1: CriCriCri"
    echo "2: Dentista"
    echo "3: Careless Whisper"
    echo "4: EA Games"
    echo "5: Harlem Shake"
    echo "6: Nespresso"
    echo "7: Nigga"
    echo "8: Por que no te callas"
    echo "9: Spanish flea"
    echo "0: Swat"
    echo "q: SALIR"
    echo ""
    read selection
    case $selection in
        1 ) cplay -q cricricri.mp3 ;;
        2 ) cplay -q dentista.mp3 ;;
        3 ) play -q careless_whisper.ogg ;;
        4 ) play -q ea_games.ogg ;;
        5 ) play -q harlem_shake.ogg ;;
        6 ) play -q nespresso.ogg ;;
        7 ) play -q nigga.ogg ;;
        8 ) play -q porque_no_te_callas.ogg ;;
        9 ) play -q spanish_flea.ogg ;;
        0 ) play -q swat.ogg ;;
        q ) exit ;;
    esac
done
