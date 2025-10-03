{
  config,
  pkgs,
  inputs,
  user,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."${user}" = import ../home-manager/home.nix;
  home-manager.backupFileExtension = ".bckp";
  home-manager.extraSpecialArgs = {
    homeUser = user;
  };
}
