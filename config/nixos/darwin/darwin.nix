{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.alacritty
    pkgs.firefox
    pkgs.jetbrains.datagrip
  ];

  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

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
