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

    tumbler = {
      enable = true;
    };

    gnome = {
      gnome-keyring.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.sway}/bin/sway";
          user = "${user}";
        };
      };
    };

    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
    };

    xserver.windowManager = {
      qtile.enable = false;
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

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
  };
}
