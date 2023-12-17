#!/bin/bash

# Obtenemos directorio donde se está ejecutando el script
script_dir=$(dirname "$0")

# Nos situamos en dicho directorio
cd "$script_dir" || exit

# Token del BOT Rpiasir
TOKEN="6888310552:AAGdmTERW4L8Dum-hhVTGcLeWKmZrzfVexw"

#ID del Canal o del usuario receptor
ID="-1001564050188"

# url de la API para enviar el mensaje
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

# Nombre del archivo para almacenar la dirección IP
archivo_ip="direccion_ip.txt"

# Obtener el nombre del equipo
nombre_equipo=$(hostname)

# Esperamos 20 segundos a que se inicien los servicios
sleep 20

# Obtener la dirección IP actual del adaptador wlan0
ip_actual=$(ip -o -4 addr show wlan0 | awk '{print $4}' | cut -d'/' -f1)

# Verificar si el archivo existe
if [ -e "$archivo_ip" ]; then
    # Obtener la dirección IP almacenada en el archivo
    ip_almacenada=$(cat "$archivo_ip")

    # Comparar la dirección IP actual con la almacenada
    if [ "$ip_actual" != "$ip_almacenada" ]; then
        # La dirección IP ha cambiado, actualizar el archivo y enviar mensaje
        echo "$ip_actual" > "$archivo_ip"
	mensaje="Nombre del equipo: $nombre_equipo  Nueva dirección IP: $ip_actual"
	curl -s -X POST $URL -d chat_id=$ID -d text="$mensaje"
    fi
else
    # El archivo no existe, crearlo y almacenar la dirección IP
    echo "$ip_actual" > "$archivo_ip"
    mensaje="Nombre del equipo: $nombre_equipo  Nueva dirección IP: $ip_actual"
    curl -s -X POST $URL -d chat_id=$ID -d text="$mensaje"
fi
