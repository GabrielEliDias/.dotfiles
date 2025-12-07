#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "    Iniciando o conserto de pacotes quebrados"
echo "--------------------------------------------------"

echo "[1/5] Configurando pacotes dpkg interrompidos..."
sudo dpkg --configure -a

echo "[2/5] Corrigindo dependências quebradas (Fix Broken)..."
sudo apt install --fix-broken -y

echo "[3/5] Atualizando lista de repositórios (Fix Missing)..."
sudo apt update --fix-missing -qq

echo "[4/5] Atualizando o sistema completo..."
sudo apt full-upgrade -y

echo "[5/5] Limpando pacotes obsoletos..."
sudo apt autoclean -y -qq
sudo apt autoremove -y -qq

echo "--------------------------------------------------"
echo "       Conserto concluído com sucesso!"
echo "--------------------------------------------------"