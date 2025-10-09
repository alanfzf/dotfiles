{
  config,
  pkgs,
  user,
  ...
}:
{

  fileSystems."/home/${user}/webdav" = {
    device = "https://app.koofr.net/dav/Koofr/";
    fsType = "davfs";
    options = [
      "rw"
      "user"
      "noauto"
    ];
  };

  services = {
    davfs2 = {
      enable = true;
      davUser = user;
      settings = {
        globalSection = {
          gui_optimize = true;
          file_refresh = 30;
        };
        sections = {
          "/home/${user}/webdav" = {
            gui_optimize = true;
            file_refresh = 30;
          };
        };
      };
    };

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
