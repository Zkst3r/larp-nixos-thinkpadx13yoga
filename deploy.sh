#!/usr/bin/env bash
set -e

echo "=== NixOS Configuration Deployment Script ==="
echo ""

# Проверка что скрипт запущен с root правами
if [ "$EUID" -ne 0 ]; then
    echo "❌ Этот скрипт должен быть запущен с sudo/root правами"
    exit 1
fi

# Определяем реального пользователя (если запущено через sudo)
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

echo "👤 Пользователь: $REAL_USER"
echo "🏠 Home: $REAL_HOME"
echo ""

# Настройка git credentials
echo "🔑 Настройка git credentials..."
read -p "Введи GitHub username (Zkst3r): " GITHUB_USER
GITHUB_USER=${GITHUB_USER:-Zkst3r}

read -sp "Введи GitHub token (или нажми Enter для SSH): " GITHUB_TOKEN
echo ""

# Клонирование репозитория
TEMP_DIR="/tmp/nixos-config-deploy"
rm -rf "$TEMP_DIR"

echo ""
echo "📥 Клонирование конфигурации..."

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Используем SSH..."
    sudo -u "$REAL_USER" git clone git@github.com:Zkst3r/larp-nixos-thinkpadx13yoga.git "$TEMP_DIR"
else
    echo "Используем HTTPS с токеном..."
    sudo -u "$REAL_USER" git clone "https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/Zkst3r/larp-nixos-thinkpadx13yoga.git" "$TEMP_DIR"
fi

# Бэкап текущего hardware-configuration.nix
echo ""
echo "💾 Сохраняем hardware-configuration.nix..."
if [ -f /etc/nixos/hardware-configuration.nix ]; then
    cp /etc/nixos/hardware-configuration.nix "$TEMP_DIR/hosts/laptop/hardware-configuration.nix"
    echo "✅ hardware-configuration.nix скопирован"
else
    echo "⚠️  hardware-configuration.nix не найден, будет использован из репо"
fi

# Бэкап старого конфига (если есть)
if [ -d /etc/nixos ] && [ "$(ls -A /etc/nixos)" ]; then
    BACKUP_DIR="/root/nixos-backup-$(date +%Y%m%d-%H%M%S)"
    echo ""
    echo "📦 Создаём бэкап старого конфига в $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
    cp -r /etc/nixos/* "$BACKUP_DIR/" 2>/dev/null || true
fi

# Копирование конфига в /etc/nixos
echo ""
echo "📋 Копируем конфиг в /etc/nixos..."
rm -rf /etc/nixos/*
cp -r "$TEMP_DIR"/* /etc/nixos/

# Установка правильных прав
chown -R root:root /etc/nixos
chmod -R 755 /etc/nixos

echo ""
echo "🔨 Запускаем nixos-rebuild switch..."
echo "Это может занять некоторое время..."
echo ""

cd /etc/nixos
nixos-rebuild switch --flake .#laptop

echo ""
echo "✅ Развёртывание завершено успешно!"
echo ""
echo "📝 Полезные команды:"
echo "  - Обновить систему: sudo nixos-rebuild switch --flake /etc/nixos#laptop"
echo "  - Обновить flake inputs: sudo nix flake update /etc/nixos"
echo "  - Проверить конфиг: sudo nixos-rebuild build --flake /etc/nixos#laptop"
echo ""
echo "🔄 Рекомендуется перезагрузиться для применения всех изменений"
