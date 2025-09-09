{
  config,
  pkgs,
  user,
  ...
}:
{
  services = {
    gvfs = {
      enable = true;
    };

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

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
    };
    config = {
      common = {
        default = [ "wlr" ];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.waydroid = {
    enable = true;
  };
}
