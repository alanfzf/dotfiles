{
  config,
  pkgs,
  inputs,
  user,
  ...
}:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = import ../home-manager/home.nix;
    backupFileExtension = ".bckp";
    extraSpecialArgs = {
      homeUser = user;
    };
  };
}
