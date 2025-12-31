#!/bin/bash
set -euo pipefail

# Determina o diretório deste menu (onde ficam os instaladores)
INSTALLERS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# organiza e executa os "managers" uma única vez (use FORCE_MANAGERS=1 para forçar)
MANAGERS_DIR="$INSTALLERS_DIR/managers"
STAMP_DIR="$HOME/.local/state/dotfiles"
STAMP_FILE="$STAMP_DIR/managers_installed"

mkdir -p "$STAMP_DIR"

if [ "${FORCE_MANAGERS:-0}" != "1" ] && [ -f "$STAMP_FILE" ]; then
	echo "Managers já instalados (marcador: $STAMP_FILE). Defina FORCE_MANAGERS=1 para reexecutar."
else
	MANAGERS=("app_image.sh" "flatpak.sh" "snap.sh")
	for m in "${MANAGERS[@]}"; do
		script="$MANAGERS_DIR/$m"
		if [ -f "$script" ]; then
			echo "Executando: $script"
			# executa com bash; os próprios scripts devem pedir sudo quando necessário
			bash "$script"
		else
			echo "Ignorado (não encontrado): $script"
		fi
	done
	touch "$STAMP_FILE"
	echo "Marca criada: $STAMP_FILE"
fi

pause() {
	read -rp $'\nPressione Enter para continuar...'
}

while true; do
	echo "------------------------------------------"
	echo "       Menu de pacotes do sistema"
	echo "------------------------------------------"
	echo "1) Pacote Básico"
	echo "2) Pacote de Desenvolvedor"
	echo "3) Pacote de Games"
	echo "4) Pacote Completo"
	echo "0) Sair"
	read -rp ">> " Opcao

	case $Opcao in
		1)
			script="$INSTALLERS_DIR/basic.sh"
			;;
		2)
			script="$INSTALLERS_DIR/dev.sh"
			;;
		3)
			script="$INSTALLERS_DIR/games.sh"
			;;
		4)
			script="$INSTALLERS_DIR/all.sh"
			;;
		0)
			echo "Saindo..."
			exit 0
			;;
		*)
			echo "Opção não válida! Tente novamente."
			pause
			continue
			;;
	esac

	if [ -x "$script" ]; then
		"$script"
	elif [ -f "$script" ]; then
		# tenta executar com bash se o arquivo existe mas não está marcado como executável
		bash "$script"
	else
		echo "Script não encontrado: $script"
	fi

	pause
done
