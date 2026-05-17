#!/bin/bash

# 1. Obtener la memoria RAM física total del servidor en Megabytes
RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')

# 2. CALCULAR LOS PORCENTAJES (Matemática automática)
# Asignaremos el 50% de la RAM total a Odoo y el 25% a PostgreSQL.
# El 25% restante se queda libre para Ubuntu, Traefik y tus scripts de backup.
ODOO_CALCULATED=$((RAM_TOTAL * 50 / 100))
DB_CALCULATED=$((RAM_TOTAL * 25 / 100))

# 3. Convertir los números al formato que Docker entiende (ejemplo: "512M")
export ODOO_MEM_LIMIT="${ODOO_CALCULATED}M"
export DB_MEM_LIMIT="${DB_CALCULATED}M"

# 4. Mostrar en pantalla el diagnóstico para que sepas qué está pasando
echo "=========================================================="
echo "🧠 DIAGNÓSTICO DE HARDWARE INTELIGENTE"
echo "=========================================================="
echo "--> RAM Total detectada en el servidor: ${RAM_TOTAL} MB"
echo "--> Asignando el 50% a Odoo:            $ODOO_MEM_LIMIT"
echo "--> Asignando el 25% a Postgres:        $DB_MEM_LIMIT"
echo "=========================================================="
echo "🚀 Levantando contenedores con límites adaptados..."

# 5. Ejecutar Docker Compose inyectándole los valores calculados
docker compose up -d