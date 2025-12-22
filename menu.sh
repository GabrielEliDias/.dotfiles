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
    echo -e "  ${GREEN}1)${NC} 🔧 Setup Inicial (Git & SSH)"
    echo -e "  ${GREEN}2)${NC} 📦 Instalar Apps (Lista Híbrida)"
    echo -e "  ${GREEN}3)${NC} 🎮 Instalar Gaming Mode (Steam/Lutris)"
    echo -e "  ${GREEN}4)${NC} 🛡️  Segurança (Firewall + Warp VPN)"
    echo -e "  ${GREEN}5)${NC} 🧹 Manutenção Completa (Limpeza + Updates)"
    echo -e "  ${RED}0)${NC} ❌ Sair"
    echo ""
    echo -e "${BLUE}=================================================${NC}"
    read -p "Opção: " choice

    case $choice in
        1)
            $BASE_DIR/setup/setup_git.sh
            pause
            ;;
        2)
            sudo $BASE_DIR/setup/install_hybrid.sh
            pause
            ;;
        3)
            sudo $BASE_DIR/setup/install_gaming.sh
            pause
            ;;
        4)
            sudo $BASE_DIR/security/firewall.sh
            echo ""
            read -p "Deseja instalar/conectar o Cloudflare Warp agora? (s/n): " INSTALL_WARP
            if [[ "$INSTALL_WARP" =~ ^[Ss]$ ]]; then
                 $BASE_DIR/security/cloudfire_warp.sh
            fi
            pause
            ;;
        5)
            sudo $BASE_DIR/maintenance/full_maintenance.sh
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