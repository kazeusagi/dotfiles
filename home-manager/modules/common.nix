{
  username,
  homeDirectory,
  ...
}:

{
  home = {
    stateVersion = "26.05";
    username = username;
    homeDirectory = homeDirectory;
  };

  imports = [
    ./common/packages.nix
    ./common/fish.nix
    ./common/nvim.nix
    ./common/zed.nix
    ./common/tmux.nix
    ./common/cloudflare.nix
  ];
}
