#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "          Iniciando a instalação Fuse"
echo "--------------------------------------------------"

echo "[1/2] Baixando e instalando o UFW..."
sudo apt install ufw -y -qq

echo "[2/2] Instalando biblioteca básica Fuse..."
sudo apt install libfuse2

echo "--------------------------------------------------"
echo "  Apps images configurados e ativo com sucesso!"
echo "--------------------------------------------------"