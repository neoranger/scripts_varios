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

# --- 2. CONFIGURACIÓN Y USO DE ICONOS ---
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
ICON_ON="${SCRIPT_DIR}/icons/coffee-on.svg"
ICON_OFF="${SCRIPT_DIR}/icons/coffee-off.svg"

# Si no existen, usar un respaldo genérico del sistema
[ ! -f "$ICON_ON" ] && ICON_ON="preferences-system-power-management"
[ ! -f "$ICON_OFF" ] && ICON_OFF="preferences-system-power-management"

# Estado inicial
ACTIVE=true
LOOP_PID=""

# Crear tubería/pipe temporal para controlar YAD en tiempo real
PIPE=$(mktemp -u)
mkfifo "$PIPE"
exec 3<>"$PIPE"

# Función para iniciar el bucle preventivo
start_preventer() {
    (
        while true; do
            xdg-screensaver reset 2>/dev/null
            xset s reset 2>/dev/null
            sleep 50
        done
    ) &
    LOOP_PID=$!
}

# Función para detener el bucle preventivo
stop_preventer() {
    if [ -n "$LOOP_PID" ]; then
        kill "$LOOP_PID" 2>/dev/null
        wait "$LOOP_PID" 2>/dev/null
        LOOP_PID=""
    fi
}

# Limpieza general al salir
cleanup() {
    stop_preventer
    [ -n "$YAD_PID" ] && kill "$YAD_PID" 2>/dev/null
    rm -f "$PIPE"
    exit 0
}
trap cleanup EXIT INT TERM

# Función para alternar estado y actualizar icono
toggle_state() {
    if $ACTIVE; then
        ACTIVE=false
        stop_preventer
        echo "icon:$ICON_OFF" >&3
        echo "tooltip:Cafeína Artesanal: Inactiva\nTu pantalla se suspenderá normalmente." >&3
        notify-send "Cafeína Artesanal" "Desactivada. La pantalla se suspenderá normalmente." -i "$ICON_OFF"
    else
        ACTIVE=true
        start_preventer
        echo "icon:$ICON_ON" >&3
        echo "tooltip:Cafeína Artesanal: Activa\nTu pantalla no se apagará." >&3
        notify-send "Cafeína Artesanal" "Activada. Tu pantalla no se apagará." -i "$ICON_ON"
    fi
}

# Capturamos la señal USR1 para alternar el estado
trap toggle_state USR1

# Iniciamos el preventer
start_preventer

# Lanzamos YAD en modo escucha con la tubería redireccionada en el descriptor 3
GDK_BACKEND=x11 yad --notification \
    --listen \
    --image="$ICON_ON" \
    --text="Cafeína Artesanal: Activa\nTu pantalla no se apagará." \
    --command="kill -USR1 $$" \
    --menu="Alternar Estado!kill -USR1 $$|Salir!quit" <&3 &
YAD_PID=$!

# Esperamos a que YAD finalice realmente (el bucle evita que el script termine al recibir señales)
while kill -0 "$YAD_PID" 2>/dev/null; do
    wait "$YAD_PID" 2>/dev/null
done

