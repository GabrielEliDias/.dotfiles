#!/bin/bash
set -euo pipefail

# Determina o diretório base (diretório pai de "maintenance")
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Possíveis nomes usados no repositório; usa o que existir
MAINT_NAMES=("maintanence" "maintenance" "maintanance")
MAINT_DIR=""
for name in "${MAINT_NAMES[@]}"; do
	[ -d "$BASE_DIR/$name" ] && MAINT_DIR="$BASE_DIR/$name" && break
done

if [ -z "$MAINT_DIR" ]; then
	echo "Diretório de manutenção não encontrado em: $BASE_DIR (tentados: ${MAINT_NAMES[*]})"
	exit 1
fi

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
	read -rp "Escolha uma opção (0-4): " MANUTENCAO_ACTION

	case $MANUTENCAO_ACTION in
		1)
			script="$MAINT_DIR/clean.sh"
			;;
		2)
			script="$MAINT_DIR/update.sh"
			;;
		3)
			script="$MAINT_DIR/fix.sh"
			;;
		4)
			script="$MAINT_DIR/full_maintenance.sh"
			;;
		0)
			echo "Saindo..."
			exit 0
			;;
		*)
			echo "Opção inválida."
			pause
			continue
			;;
	esac

	if [ -x "$script" ]; then
		"$script"
	elif [ -f "$script" ]; then
		# tenta executar com bash se não for executável
		bash "$script"
	else
		echo "Script não encontrado: $script"
	fi

	pause
done

