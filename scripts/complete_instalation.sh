#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Diretório do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

trap 'echo; echo "Interrompido pelo usuário."; exit 130' INT

while true; do
	echo "-----------------------------------------------"
	echo "   Iniciando a instalação completa do sistema"
	echo "-----------------------------------------------"
	echo "Deseja continuar com a instalação? (1 - Sim, 2 - Não)"
	read -r -p ">> " Escolha

	case "$Escolha" in 
		1)
			# Executa o instalador principal se existir
			if [[ -x "$SCRIPT_DIR/installers/menu.sh" ]]; then
				sudo bash "$SCRIPT_DIR/installers/menu.sh"
			else
				echo "Script não encontrado ou não executável: $SCRIPT_DIR/installers/menu.sh"
				exit 1
			fi

			# Executa o script de segurança se existir
			if [[ -x "$SCRIPT_DIR/security/security.sh" ]]; then
				sudo bash "$SCRIPT_DIR/security/security.sh"
			else
				echo "Aviso: script de segurança não encontrado: $SCRIPT_DIR/security/security.sh"
			fi

			echo "Instalação concluída."
			exit 0
			;;
		2)
			echo "Fechando o sistema de instalação automatizada do sistema!"
			read -r -p "Pressione Enter para sair..."
			exit 0
			;;
		*)
			echo "Comando não válido! Digite novamente."
			sleep 1
			;;
	esac
done
