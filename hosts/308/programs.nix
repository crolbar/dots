{pkgs, ...}: {
  programs = {
    hyprland.enable = true;
    sway.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      nvtopPackages.nvidia # gpu monitor
      mesa
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      libva
      libva-utils

      # xfce.xfce4-systemload-plugin
    ];
  };
}
