# NixOS Configuration

Личная конфигурация NixOS для ThinkPad X13 Yoga.

## Быстрая установка

### Автоматический деплой (рекомендуется)

Если у тебя уже установлен NixOS через графический установщик:

```bash
# Скачай и запусти скрипт деплоя
curl -o deploy.sh https://raw.githubusercontent.com/Zkst3r/larp-nixos-thinkpadx13yoga/main/deploy.sh
chmod +x deploy.sh
sudo ./deploy.sh
```

Скрипт:
- Клонирует репозиторий
- Сохранит твой `hardware-configuration.nix`
- Забэкапит старый конфиг в `/root/nixos-backup-*`
- Скопирует конфиг в `/etc/nixos`
- Запустит `nixos-rebuild switch --flake .#laptop`

После завершения перезагрузись.

### Ручная установка

Если хочешь контроль над процессом:

```bash
# 1. Бэкап старого конфига
sudo cp -r /etc/nixos /root/nixos-backup-$(date +%Y%m%d)

# 2. Клонирование репо
cd /tmp
git clone https://github.com/Zkst3r/larp-nixos-thinkpadx13yoga.git

# 3. Сохранение hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix /tmp/larp-nixos-thinkpadx13yoga/hosts/laptop/

# 4. Копирование конфига
sudo rm -rf /etc/nixos/*
sudo cp -r /tmp/larp-nixos-thinkpadx13yoga/* /etc/nixos/

# 5. Применение конфига
cd /etc/nixos
sudo nixos-rebuild switch --flake .#laptop

# 6. Перезагрузка
sudo reboot
```

## Требования

Перед установкой убедись что в системе включены:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

И установлены базовые пакеты:
```nix
environment.systemPackages = with pkgs; [ git curl ];
```

## Обновление системы

```bash
# Обновить конфиг
cd /etc/nixos
sudo nixos-rebuild switch --flake .#laptop

# Обновить flake inputs
sudo nix flake update
sudo nixos-rebuild switch --flake .#laptop
```

## Откат изменений

```bash
# Откат на предыдущее поколение
sudo nixos-rebuild switch --rollback

# Просмотр всех поколений
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

## Структура конфига

```
.
├── flake.nix              # Entry point
├── hosts/
│   └── laptop/
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules/
│   ├── home/              # Home-manager конфиги
│   └── system/            # Системные модули
└── deploy.sh              # Скрипт автоматического деплоя
```
