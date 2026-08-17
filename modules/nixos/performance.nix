{ ... }:

{
  # --- Планировщик и ядро ---
  boot.kernel.sysctl = {
    # Меньше свопить на диск, zram справится
    "vm.swappiness"             = 10;
    # Группировать процессы по сессиям, снижает latency
    "kernel.sched_autogroup_enabled" = 1;
    # Агрессивнее кэшировать inode/dentry
    "vm.vfs_cache_pressure"     = 50;
  };

  # Распределять аппаратные прерывания по всем ядрам
  services.irqbalance.enable = true;

  # --- Сборка Nix ---
  nix.settings = {
    # Использовать все доступные ядра
    max-jobs = "auto";
    cores    = 0;
  };

  # Автоматический GC: удалять поколения старше 14 дней раз в неделю
  nix.gc = {
    automatic  = true;
    dates      = "weekly";
    options    = "--delete-older-than 14d";
  };

  # Автоматически оптимизировать nix store (дедупликация хардлинками)
  nix.settings.auto-optimise-store = true;
}
