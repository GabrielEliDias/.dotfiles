# 🛠️ Linux Maintenance & Setup Toolkit

Uma suíte de scripts em Bash para automação de manutenção, reparo, segurança e atualização de sistemas baseados em Debian/Ubuntu.

## 📋 Pré-requisitos (Apenas para Debian Puro)

Se você acabou de instalar o **Debian** e não configurou o `sudo` durante a instalação, você precisará dar permissões ao seu usuário antes de rodar este projeto.

1. Abra o terminal e logue como root:
   ```bash
   su -
   apt update && apt install sudo -y && usermod -aG sudo $(logname) && reboot
   ```
   Após isso ele deve reinicar e pode dar autoridade e rodar o script menu.sh
   