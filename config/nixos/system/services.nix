{ config, pkgs, ... }:
{
  services = {
    gnome = {
      gnome-keyring.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "alan";
        };
      };
    };
  };
}
