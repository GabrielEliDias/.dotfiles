#!/bin/bash

set -e 

if [ $SUDO_USER ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$USER
fi

USER_HOME="/home/$REAL_USER"

echo "--------------------------------------------------"
echo "   Iniciando a Limpeza do sistema para: $REAL_USER"
echo "--------------------------------------------------"

echo "[1/7] Esvaziando a Lixeira..."
sudo rm -rf $USER_HOME/.local/share/Lixeira/*

echo "[2/7] Apagando Arquivos Temporários do Sistema..."
sudo rm -rf /var/tmp/*

sudo apt clean -y

echo "[4/7] Removendo dependências inúteis (autoremove)..."
sudo apt autoremove -y

echo "[5/7] Limpar cache de arquivos antigos (autoclean)..."
sudo apt autoclean -y

echo "[6/7] Apagando Downloads com mais de 15 dias..."

find $USER_HOME/Downloads -type f -mtime +15 -delete || true

echo "[7/7] Apagando Capturas de Tela com mais de 15 dias..."
find $USER_HOME/Pictures -type f -mtime +15 -delete || true

echo "--------------------------------------------------"
echo "        Limpeza concluída com sucesso!"
echo "--------------------------------------------------"