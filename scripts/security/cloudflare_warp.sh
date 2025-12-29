#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "    Iniciando a instalação do Cloudflare Warp"
echo "--------------------------------------------------"

echo "[1/6] Adicionando chave GPG oficial..."
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

echo "[2/6] Adicionando o repositório..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-warp.list > /dev/null

echo "[3/6] Atualizando lista de pacotes..."
sudo apt update -qq

echo "[4/6] Instalando o Cloudflare Warp Client..."
sudo apt install cloudflare-warp -y

echo "[5/6] Registrando o dispositivo (Nova Sintaxe)..."
sudo warp-cli registration new || true
sudo warp-cli mode warp

echo "[6/6] Conectando..."
sudo warp-cli connect

echo "--------------------------------------------------"
echo "        Instalação e Conexão concluídas!"
echo "--------------------------------------------------"
echo "Status Atual:"
sudo warp-cli status
echo ""
echo "Dica: Para desconectar use 'sudo warp-cli disconnect'"