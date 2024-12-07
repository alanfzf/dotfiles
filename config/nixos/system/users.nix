{
  users.users  = {
    "alan" = {
      # NOTE: don't manage user packages here, use home-manager instead
      isNormalUser = true;
      description = "alan";
      extraGroups = [ "networkmanager" "wheel" ]; 
    };
  };
}
