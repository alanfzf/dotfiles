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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --user-menu --asterisks --cmd sway";
          user = "${user}";
        };
      };
    };
  };
}
