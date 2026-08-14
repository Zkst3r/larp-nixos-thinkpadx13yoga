{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.kster = {
    isNormalUser = true;
    shell        = pkgs.fish;
    description  = "kster";
    extraGroups  = [ "networkmanager" "wheel" "docker" ];
  };

  environment.shellAliases = {
    switch-laptop = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
  };
}
