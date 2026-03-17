#!/bin/bash

# --- 1. COMPROBACIÓN E INSTALACIÓN DE DEPENDENCIAS ---
comprobar_dependencias() {
    PAQUETES_FALTANTES=""

    # Verificamos si falta yad
    if ! command -v yad &> /dev/null; then
        PAQUETES_FALTANTES="yad "
    fi

    # xdg-screensaver viene en el paquete xdg-utils
    if ! command -v xdg-screensaver &> /dev/null; then
        PAQUETES_FALTANTES+="xdg-utils "
    fi

    # Si falta algún paquete, pedimos permisos e instalamos
    if [ -n "$PAQUETES_FALTANTES" ]; then
        # Enviamos una notificación al sistema para avisar qué está pasando
        notify-send "Cafeína Artesanal" "Instalando dependencias necesarias: $PAQUETES_FALTANTES"
        
        # pkexec abre la ventana gráfica de KDE para pedir la contraseña de sudo
        if pkexec bash -c "apt-get update && apt-get install -y $PAQUETES_FALTANTES"; then
            notify-send "Cafeína Artesanal" "Dependencias instaladas correctamente. Iniciando..."
        else
            notify-send -u critical "Cafeína Artesanal" "Error al instalar. Se canceló la operación."
            exit 1
        fi
    fi
}

# Ejecutamos la comprobación antes de iniciar el programa
comprobar_dependencias

# --- 2. LÓGICA DE LA APLICACIÓN ---

# Función para limpiar el proceso en segundo plano al salir
cleanup() {
    kill $LOOP_PID 2>/dev/null
    exit 0
}

# Atrapamos la señal de cierre para ejecutar 'cleanup'
trap cleanup EXIT

# Lanzamos el bucle anti-suspensión en segundo plano
(
    while true; do
        xdg-screensaver reset
        sleep 50
    done
) &
LOOP_PID=$! # Guardamos el ID del proceso

# Lanzamos el ícono en el systray (compatible con KDE Wayland/X11)
GDK_BACKEND=x11 yad --notification \
    --image="preferences-system-power-management" \
    --text="Cafeína Artesanal Activa\nTu pantalla no se apagará." \
    --menu="Detener y Salir!quit"
