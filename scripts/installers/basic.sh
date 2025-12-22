#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST_FILE="$SCRIPT_DIR/scripts/lists/base.txt"
APT_TO_INSTALL=""
MANUAL_STEPS=()

echo "--------------------------------------------------"
echo "      🎮 Setup de instalação Básica (Híbrido)"
echo "--------------------------------------------------"

echo ">> Habilitando arquitetura 32-bit..."
sudo dpkg --add-architecture i386
sudo apt update -qq

if ! command -v flatpak &> /dev/null; then sudo apt install flatpak -y; fi
if ! command -v snap &> /dev/null; then sudo apt install snapd -y; fi

# Adiciona repo do Flathub se não existir
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ""
echo ">> Lendo lista de programas e ferramentas..."

# Loop linha por linha
while IFS= read -r line || [ -n "$line" ]; do
    # 1. Remove comentários (tudo depois de #) e espaços em branco extras
    CLEAN_LINE=$(echo "$line" | cut -d'#' -f1 | xargs)

    # Se a linha estiver vazia após limpeza, pula
    if [ -z "$CLEAN_LINE" ]; then continue; fi

    # 2. Separa o Gerente (manager) do Pacote (package)
    # Pega tudo antes do primeiro ':'
    MANAGER=$(echo "$CLEAN_LINE" | cut -d':' -f1 | tr '[:upper:]' '[:lower:]')
    # Pega tudo depois do primeiro ':'
    PACKAGE=$(echo "$CLEAN_LINE" | cut -d':' -f2- | xargs)

    case "$MANAGER" in
        apt)
            echo " -> Adicionado à fila do APT: $PACKAGE"
            APT_TO_INSTALL="$APT_TO_INSTALL $PACKAGE"
            ;;
        flatpak)
            echo " -> Instalando Flatpak: $PACKAGE"
            flatpak install flathub "$PACKAGE" -y
            ;;
        snap)
            echo " -> Instalando Snap: $PACKAGE"
            sudo snap install "$PACKAGE"
            ;;
        script)
            echo " -> [!] Script/Manual detectado: $PACKAGE"
            MANUAL_STEPS+=("$PACKAGE")
            ;;
        *)
            echo " -> Ignorando gerenciador desconhecido: $MANAGER"
            ;;
    esac

done < "$LIST_FILE"

echo ""
echo "--------------------------------------------------"
echo "      Executando instalação em massa do APT"
echo "--------------------------------------------------"
if [ -n "$APT_TO_INSTALL" ]; then
    # O DEBIAN_FRONTEND=noninteractive evita perguntas chatas
    sudo DEBIAN_FRONTEND=noninteractive apt install -y $APT_TO_INSTALL
else
    echo "Nenhum pacote APT encontrado na lista."
fi

echo ""
echo "--------------------------------------------------"
echo "      ⚠️  AÇÕES MANUAIS NECESSÁRIAS  ⚠️"
echo "--------------------------------------------------"
if [ ${#MANUAL_STEPS[@]} -eq 0 ]; then
    echo "Nenhuma ação manual pendente."
else
    echo "Os seguintes itens requerem sua atenção (scripts externos):"
    for step in "${MANUAL_STEPS[@]}"; do
        echo " • $step"
    done
fi

echo ""
echo "Setup Básico concluído!"