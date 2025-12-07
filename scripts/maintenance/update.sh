#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "    Iniciando a atualização do sistema e apps"
echo "--------------------------------------------------"

echo "[1/4] Sincronizando repositórios (Apt Update)..."
sudo apt update --fix-missing -qq

echo "[2/4] Instalando atualizações do sistema (Apt Upgrade)..."
sudo apt full-upgrade -y -qq

if command -v snap &> /dev/null; then
    echo "[3/4] Atualizando pacotes SNAP..."
    sudo snap refresh
else
    echo "[3/4] Snap não detectado. Pulando..."
fi

if command -v flatpak &> /dev/null; then
    echo "[4/4] Atualizando pacotes FLATPAK..."
    flatpak update -y
else
    echo "[4/4] Flatpak não detectado. Pulando..."
fi

echo "--------------------------------------------------"
echo "        Atualização concluída com sucesso!"
echo "--------------------------------------------------"