#!/bin/bash

set -e 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================================="
echo " INICIANDO INSTALAÇÂO COMPLETA DA SEGURANÇA REDES"
echo "=================================================="
echo ""

echo ">> [FASE 1/2] Executando instalação do sistemas de redes..."
bash "$SCRIPT_DIR/cloudflare_warp.sh"
echo ""

echo ">> [FASE 2/2] Executando configuração do firewall..."
bash "$SCRIPT_DIR/firewall.sh"
echo ""

echo "=================================================="
echo "   TODO O PROCESSO FOI CONCLUÍDO COM SUCESSO!"
echo "=================================================="