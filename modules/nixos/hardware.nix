{ pkgs, lib, ... }:

{
  # Laptop sensors & input
  hardware.sensor.iio.enable = true;
  services.libinput.enable   = true;
  services.upower.enable     = true;

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = lib.mkForce true;
  security.pam.services.sudo.fprintAuth  = lib.mkForce true;

  # KDE Connect (phone integration)
  programs.kdeconnect.enable = true;

  # Power management
  services.power-profiles-daemon.enable = true;
  services.thermald.enable              = true;
  powerManagement.powertop.enable       = true;

  # Intel GPU
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable      = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      intel-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      libvdpau-va-gl
      intel-vaapi-driver
    ];
  };

  # Compressed swap
  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 50;
  };

  # Laptop-specific utilities
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    rot8
    squeekboard
    powertop
    intel-gpu-tools
  ];
}
