#!/bin/bash

set -e

echo "--------------------------------------------------"
echo "      Configurando Git e Chaves SSH"
echo "--------------------------------------------------"

if ! command -v git &> /dev/null; then
    echo "[1/4] Git não encontrado. Instalando..."
    sudo apt update -qq
    sudo apt install git -y -qq
else 
    echo "[1/4] Git já está instalado. Pulando instalação..."
fi

echo "[2/4] Coletando dados do usuário..."
read -p "Digite o Nome para o Git (ex: Fulano): " GIT_NAME
read -p "Digite o Email para o Git (ex: email@exemplo.com): " GIT_EMAIL

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo "Erro: Nome e Email são obrigatórios."
    exit 1
fi

echo "[3/4] Aplicando configurações globais..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor nano
git config --global credential.helper store

echo "[4/4] Configurando Chave SSH (Opcional)..."
echo "Isso é necessário para conectar ao GitHub/GitLab sem senha."
read -p "Deseja gerar uma nova chave SSH agora? (s/n): " GENERATE_SSH

if [[ "$GENERATE_SSH" =~ ^[Ss]$ ]]; thens
    if [ -f "$HOME/.ssh/id_ed25519" ]; then
        echo "Aviso: Já existe uma chave SSH (id_ed25519). O processo foi abortado para segurança."
    else
        # Gera a chave
        ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
        
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"
        
        echo ""
        echo "--------------------------------------------------"
        echo "COPIE A CHAVE ABAIXO E COLE NO GITHUB/GITLAB:"
        echo "--------------------------------------------------"
        cat "$HOME/.ssh/id_ed25519.pub"
        echo "--------------------------------------------------"
        echo "Link para adicionar no GitHub: https://github.com/settings/ssh/new"
    fi
else
    echo "Pulando etapa SSH..."
fi

echo "--------------------------------------------------"
echo "      Configuração do Git concluída!"
echo "--------------------------------------------------"