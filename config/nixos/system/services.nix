{
  config,
  pkgs,
  user,
  ...
}:
{
  services = {
    gnome = {
      gnome-keyring.enable = true;
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    xserver.windowManager = {
      qtile.enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
  };
}
