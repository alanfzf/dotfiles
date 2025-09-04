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

    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --asterisks --cmd sway";
          user = "${user}";
        };
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };
}
