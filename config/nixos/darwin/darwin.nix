{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.aerospace
    pkgs.alacritty
    pkgs.discord
    pkgs.mkalias
    pkgs.jetbrains.datagrip
    pkgs.qemu
  ];

  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # fix for spotlight
  # https://github.com/LnL7/nix-darwin/issues/139#issuecomment-1230728610
  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = false;
      AppleShowScrollBars = "Always";
      NSAutomaticWindowAnimationsEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      # 120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;
      # 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 15;
    };

    finder = {
      AppleShowAllExtensions = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      mru-spaces = false;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };

    screensaver = {
      askForPasswordDelay = 10;
    };
  };

  time = {
    timeZone = "America/Guatemala";
  };

  homebrew = {
    enable = false;
    casks = [ ];
    brews = [ ];
    masApps = [ ];
  };
}
