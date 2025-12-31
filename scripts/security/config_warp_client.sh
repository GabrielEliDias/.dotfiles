#!/bin/bash

set -e 

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Verificação e Instalação do Firewall (UFW) ---
if ! command -v ufw &> /dev/null; then
    echo "UFW não encontrado. Iniciando configuração do firewall..."
    sudo "$BASE_DIR/firewall.sh"
else
    echo "UFW já está instalado. Pulando etapa."
fi

echo ""

# --- Verificação e Instalação do Cloudflare Warp ---
if ! command -v warp-cli &> /dev/null; then
    # O Warp não existe, então perguntamos se quer instalar
    read -p "Deseja instalar o Cloudflare Warp agora? (s/n): " INSTALL_WARP
    if [[ "$INSTALL_WARP" =~ ^[Ss]$ ]]; then
        sudo "$BASE_DIR/cloudflare_warp.sh"
    fi
else
    echo "Cloudflare Warp Client já está instalado. Pulando instalação."
fi

if command -v warp-cli &> /dev/null; then
    echo "------------------------------------------"
    echo "Configuração do Cloudflare WARP"
    echo "------------------------------------------"
    echo "1) Ativar/Conectar (Criptografar tráfego)"
    echo "2) Desativar/Desconectar (Tráfego direto)"
    echo "3) Manter estado atual / Pular"
    read -p "Escolha uma opção (1-3): " WARP_ACTION

    case $WARP_ACTION in
        1)
            echo "Ativando WARP..."
            warp-cli connect
            ;;
        2)
            echo "Desativando WARP..."
            warp-cli disconnect
            ;;
        3)
            echo "Nenhuma alteração feita no estado do WARP."
            ;;
        *)
            echo "Opção inválida, pulando..."
            ;;
    esac
else
    echo "WARP não detectado. Pulei a configuração de ativação."
fi

echo ""
read -n 1 -s -r -p "Pressione qualquer tecla para continuar..."