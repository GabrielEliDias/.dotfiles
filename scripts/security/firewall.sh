#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "   Iniciando a instalação e configuração do UFW"
echo "--------------------------------------------------"

echo "[1/6] Baixando e instalando o UFW..."
sudo apt install ufw -y -qq

echo "[2/6] Definindo políticas padrão (Segurança Base)..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[3/6] Permitindo acesso SSH (Para não perder acesso)..."
sudo ufw allow ssh

echo "[4/6] Configurando servidor Web..."
sudo ufw allow 80/tcp  
sudo ufw allow 443/tcp  

echo "[5/6] Ativando o firewall..."
sudo ufw --force enable

echo "[6/6] Verificando status..."
sudo ufw status verbose

echo "--------------------------------------------------"
echo "    Firewall configurado e ativo com sucesso!"
echo "--------------------------------------------------"