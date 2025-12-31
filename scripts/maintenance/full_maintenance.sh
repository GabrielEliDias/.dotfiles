#!/bin/bash

set -e 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================================="
echo "   INICIANDO MANUTENÇÃO COMPLETA DO SISTEMA"
echo "=================================================="
echo ""

echo ">> [FASE 1/3] Executando rotinas de reparo..."
bash "$SCRIPT_DIR/fix.sh"
echo ""

echo ">> [FASE 2/3] Executando atualizações..."
bash "$SCRIPT_DIR/update.sh"
echo ""

echo ">> [FASE 3/3] Executando limpeza final..."
bash "$SCRIPT_DIR/clean.sh" 
echo ""

echo "=================================================="
echo "   TODO O PROCESSO FOI CONCLUÍDO COM SUCESSO!"
echo "=================================================="