# telegramip
Envío por Telegram de la dirección IP al arrancar

Asignamos permisos al fichero:

`chmod a+x telegramip/mensaje.sh`

Modificamos nuestro fichero cron:

`crontab -e`

Añadimos la siguiente línea sustituyendo la ruta del fichero por la que corresponda:

`@reboot /home/alumno/telegramip/mensaje.sh`
