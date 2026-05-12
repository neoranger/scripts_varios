#!/bin/bash

# --- 1. COMPROBACIÓN E INSTALACIÓN DE DEPENDENCIAS ---
comprobar_dependencias() {
    PAQUETES_FALTANTES=""

    # Dependencias básicas de comandos
    if ! command -v yad &> /dev/null; then PAQUETES_FALTANTES+="yad "; fi
    if ! command -v xdg-screensaver &> /dev/null; then PAQUETES_FALTANTES+="xdg-utils "; fi
    if ! command -v xset &> /dev/null; then
        # Detectamos qué paquete instalar según el gestor disponible
        if command -v pacman &> /dev/null; then
            PAQUETES_FALTANTES+="xorg-xset "
        elif command -v apt-get &> /dev/null; then
            PAQUETES_FALTANTES+="x11-xserver-utils "
        fi
    fi

    if [ -n "$PAQUETES_FALTANTES" ]; then
        notify-send "Cafeína Artesanal" "Instalando dependencias necesarias: $PAQUETES_FALTANTES"

        if command -v pacman &> /dev/null; then
            COMANDO_INSTALACION="pacman -Sy --noconfirm $PAQUETES_FALTANTES"
        elif command -v apt-get &> /dev/null; then
            COMANDO_INSTALACION="apt-get update && apt-get install -y $PAQUETES_FALTANTES"
        fi

        if pkexec bash -c "$COMANDO_INSTALACION"; then
            notify-send "Cafeína Artesanal" "Dependencias instaladas correctamente."
        else
            notify-send -u critical "Cafeína Artesanal" "Error al instalar. Se canceló la operación."
            exit 1
        fi
    fi
}

comprobar_dependencias

# --- 2. LÓGICA DE LA APLICACIÓN ---

cleanup() {
    [ -n "$LOOP_PID" ] && kill $LOOP_PID 2>/dev/null
    exit 0
}

trap cleanup EXIT

(
    while true; do
        # Resetea el contador de inactividad
        xdg-screensaver reset 2>/dev/null
        # Opcional: un segundo método por si xdg-screensaver falla en algunos WM
        xset s reset 2>/dev/null
        sleep 50
    done
) &
LOOP_PID=$!

# Ejecución del ícono en la bandeja
GDK_BACKEND=x11 yad --notification \
    --image="preferences-system-power-management" \
    --text="Cafeína Artesanal Activa\nTu pantalla no se apagará." \
    --command="bash -c 'kill $PPID'" \
    --menu="Detener y Salir!quit"
