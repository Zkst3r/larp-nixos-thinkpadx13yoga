{ pkgs, ... }: {
  hardware.sensor.iio.enable = true;
  services.libinput.enable = true;
  services.upower.enable = true;  

  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    rot8
    squeekboard
    powertop
    intel-gpu-tools
  ];
  
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;  
 
  services.xserver.videoDrivers = ["modesetting"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      intel-vaapi-driver
     # vulkan-loader
     # vulkan-headers
     # vulkan-validation-layers
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      libvdpau-va-gl
      intel-vaapi-driver
     # vulkan-loader
     # vulkan-headers
     # vulkan-validation-layers
    ];
  };
}
