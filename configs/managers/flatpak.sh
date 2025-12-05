#!/bin/bash

set -e 

echo "--------------------------------------------------"
echo "      Iniciando a instalação do Flatpak"
echo "--------------------------------------------------"

echo "[1/3] Atualizando repositórios..."
sudo apt update -qq  # -qq reduz a saída de texto (quiet)

echo "[2/3] Instalando Flatpak e dependências..."
sudo apt install -y flatpak gnome-software-plugin-flatpak

echo "[3/3] Adicionando repositório Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "--------------------------------------------------"
echo "      Instalação concluída com sucesso!"
echo "--------------------------------------------------"