.PHONY: help setup apps gaming security maintenance menu permissions

# Cor padrão para o help
DEFAULT_GOAL := help

# Caminhos dos scripts
SCRIPT_DIR = ./scripts

help:
	@echo "🛠️  Linux Setup Toolkit - Comandos Disponíveis:"
	@echo "--------------------------------------------------"
	@echo "  make menu         -> Abre o menu interativo (Recomendado)"
	@echo "  make setup        -> Configura Git e Chaves SSH"
	@echo "  make apps         -> Instala lista de apps (Híbrida)"
	@echo "  make gaming       -> Instala ambiente de jogos"
	@echo "  make security     -> Configura Firewall e VPN"
	@echo "  make maintenance  -> Roda limpeza e atualizações"
	@echo "  make permissions  -> Dá permissão de execução (+x) nos scripts"
	@echo "--------------------------------------------------"

permissions:
	@echo "🔧 Dando permissão de execução para todos os scripts..."
	@chmod +x $(SCRIPT_DIR)/**/*.sh
	@chmod +x menu.sh

setup: permissions
	@$(SCRIPT_DIR)/setup/setup_git.sh

apps: permissions
	@$(SCRIPT_DIR)/setup/install_hybrid.sh

gaming: permissions
	@$(SCRIPT_DIR)/setup/install_gaming.sh

security: permissions
	@$(SCRIPT_DIR)/security/firewall.sh
	@$(SCRIPT_DIR)/security/cloudfire_warp.sh

maintenance: permissions
	@$(SCRIPT_DIR)/maintenance/full_maintenance.sh

menu: permissions
	@./menu.sh