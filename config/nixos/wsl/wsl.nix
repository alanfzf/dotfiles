{ user, ... }:
{
  wsl = {
    enable = true;
    defaultUser = user;
  };
}
