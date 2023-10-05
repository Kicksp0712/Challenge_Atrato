#!/bin/bash

# Actualizar e instalar los paquetes
sudo apt-get update -y
sudo apt-get install -y python3-pip

# Instalar flask
pip3 install Flask

# Copiar la app de python al directorio home
cp /app/app.py ~/app.py

# Correr app
python3 ~/your_python_app.py

# Cron job diario para hacer el upgrade de seguridad
echo "0 0 * * * /usr/bin/apt-get update && /usr/bin/apt-get -y upgrade" | crontab -