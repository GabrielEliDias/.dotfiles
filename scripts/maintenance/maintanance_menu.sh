#!/bin/bash
set -euo pipefail

# Define o diretório onde ESTE script está (scripts/maintenance)
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pause() {
	read -rp $'\nPressione Enter para continuar...'
}

while true; do
	echo "------------------------------------------"
	echo "      Menu de manutenção do sistema"
	echo "------------------------------------------"
	echo "1) Limpeza de arquivos sem utilidade"
	echo "2) Updates do sistema"
	echo "3) Conserto de quebra de pacotes"
	echo "4) Manutenção completa do sistema"
	echo "0) Sair"
	
	read -rp "Escolha uma opção (0-4): " MAINT_ACTION

    case $MAINT_ACTION in
        1)
            # Chama o script que está na MESMA pasta
            sudo "$CURRENT_DIR/clean.sh"
            ;;
        2)
            sudo "$CURRENT_DIR/update.sh"
            ;;
        3)
            sudo "$CURRENT_DIR/fix.sh"
            ;;
        4)
            sudo "$CURRENT_DIR/full_maintenance.sh"
            ;;
        0)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida"
            ;;
    esac
    pause
done

