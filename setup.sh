#!/bin/bash

set -e

echo "🔄 Yangilanishlar..."
sudo apt update && sudo apt upgrade -y

echo "📦 Asosiy paketlar..."
sudo apt install -y curl git wget gpg htop tmux software-properties-common apt-transport-https ca-certificates gnupg lsb-release

# 1. Node.js via nvm
echo "🟢 NVM va Node.js LTS o'rnatilmoqda..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts

# 2. VSCode
echo "🟣 VSCode o'rnatilmoqda..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# 3. PostgreSQL & pgAdmin
echo "🟤 PostgreSQL va pgAdmin o'rnatilmoqda..."
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql postgresql-client

echo "🔵 pgAdmin4 o'rnatilmoqda..."
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor | sudo tee /usr/share/keyrings/pgadmin.gpg >/dev/null
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/pgadmin.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
sudo apt update
sudo apt install -y pgadmin4-desktop

# 4. MongoDB CLI
echo "🟢 MongoDB o'rnatilmoqda..."
wget -qO - https://pgp.mongodb.com/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/mongodb.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org

# 5. MongoDB Compass
echo "🟢 MongoDB Compass o'rnatilmoqda..."
wget https://downloads.mongodb.com/compass/mongodb-compass_1.42.3_amd64.deb -O compass.deb
sudo apt install -y ./compass.deb
rm compass.deb

# 6. Docker + Desktop
echo "🐳 Docker o'rnatilmoqda..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Docker Desktop
echo "🖥 Docker Desktop o'rnatilmoqda..."
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.31.0-amd64.deb -O docker-desktop.deb
sudo apt install -y ./docker-desktop.deb
rm docker-desktop.deb

# 7. Postman (Snap orqali)
echo "📮 Postman o'rnatilmoqda..."
sudo snap install postman

# 8. Chrome
echo "🌐 Google Chrome o'rnatilmoqda..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo apt install -y ./chrome.deb
rm chrome.deb

# 9. Termius
echo "🔐 Termius o'rnatilmoqda..."
sudo snap install termius-app

# 10. Telegram
echo "✉️ Telegram o'rnatilmoqda..."
sudo snap install telegram-desktop

echo "✅ Hammasi muvoffaqiyatli o'rnatildi!"
