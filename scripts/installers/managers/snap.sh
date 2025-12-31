#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "      Iniciando a instalação do Snap"
echo "--------------------------------------------------"

echo "[1/3] Atualizando repositórios..."
sudo apt update -qq  # -qq reduz a saída de texto (quiet)

echo "[2/3] Instalando Snap e dependências..."
sudo apt install -y snapd 
sudo snap install snapd

echo "[3/3] Adicionando loja Snap ao sistema..."
sudo snap install snap-store

echo "--------------------------------------------------"
echo "      Instalação concluída com sucesso!"
echo "--------------------------------------------------"