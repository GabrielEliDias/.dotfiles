#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BASE_DIR="./scripts"

pause() {
    echo ""
    read -p "Pressione [Enter] para voltar ao menu..."
}

show_header() {
    clear
    echo -e "${BLUE}=================================================${NC}"
    echo -e "${CYAN}      🐧 DEBIAN SETUP & MAINTENANCE HUB 🐧       ${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

while true; do
    show_header
    echo -e "${YELLOW}Selecione uma opção:${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC} Setup Inicial Completo"
    echo -e "  ${GREEN}2)${NC} Instalar Pacotes (Lista Híbrida)"
    echo -e "  ${GREEN}3)${NC} Organizar Arquivos importantes (Configs)"
    echo -e "  ${GREEN}4)${NC} Segurança (Firewall + Warp VPN)"
    echo -e "  ${GREEN}5)${NC} Manutenção Completa (Limpeza + Updates)"
    echo -e "  ${RED}0)${NC} Sair"
    echo ""
    echo -e "${BLUE}=================================================${NC}"
    read -p "Opção: " choice

    case $choice in
        1)
            $BASE_DIR/setup/setup_git.sh
            pause
            ;;
        2)
            sudo $BASE_DIR/scripts/installers/menu.sh #pronto!
            pause
            ;;
        3)
            echo "Função ainda não implementada no sistema"
            pause
            ;;
        4)
            sudo $BASE_DIR/security/config_warp_client.sh #pronto!
            pause
            ;;
        5)  
            sudo $BASE_DIR/maintenance/maintenance_menu.sh #pronto!
            pause
            ;;
        0)
            echo -e "${CYAN}Saindo... Até logo! 👋${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opção inválida!${NC}"
            sleep 1
            ;;
    esac
done