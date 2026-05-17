#!/bin/bash

# 1. Obtener la memoria RAM física total del servidor en Megabytes
RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')

# 2. CALCULAR LOS PORCENTAJES
ODOO_CALCULATED=$((RAM_TOTAL * 50 / 100))
DB_CALCULATED=$((RAM_TOTAL * 25 / 100))

# 3. 📝 NUEVO: Guardar los valores directamente en el archivo .env de Docker
echo "ODOO_MEM_LIMIT=${ODOO_CALCULATED}M" > .env
echo "DB_MEM_LIMIT=${DB_CALCULATED}M" >> .env

# 4. Mostrar en pantalla el diagnóstico
echo "=========================================================="
echo "🧠 DIAGNÓSTICO DE HARDWARE INTELIGENTE"
echo "=========================================================="
echo "--> RAM Total detectada en el servidor: ${RAM_TOTAL} MB"
echo "--> Asignando el 50% a Odoo:            ${ODOO_CALCULATED}M"
echo "--> Asignando el 25% a Postgres:        ${DB_CALCULATED}M"
echo "=========================================================="
echo "🚀 Levantando contenedores con archivo .env guardado..."

# 5. Ejecutar Docker Compose normal
docker compose up -d