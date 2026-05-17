#!/bin/bash

# 1. Obtener la memoria RAM física total
RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')

# 2. CALCULAR LOS PORCENTAJES PARA STAGING (Valores más bajos)
# Usamos el 30% para Odoo de pruebas y 15% para su base de datos.
ODOO_CALCULATED=$((RAM_TOTAL * 30 / 100))
DB_CALCULATED=$((RAM_TOTAL * 15 / 100))

# 3. Exportar las variables exclusivas de Staging
export ODOO_STG_LIMIT="${ODOO_CALCULATED}M"
export DB_STG_LIMIT="${DB_CALCULATED}M"

echo "=========================================================="
echo "🧪 ENTORNO DE PRUEBAS: STAGING"
echo "=========================================================="
echo "--> RAM Total en servidor:      ${RAM_TOTAL} MB"
echo "--> Asignando 30% a Odoo Stg:   $ODOO_STG_LIMIT"
echo "--> Asignando 15% a Postgres Stg: $DB_STG_LIMIT"
echo "=========================================================="
echo "🚀 Levantando Staging de forma controlada..."

docker compose up -d