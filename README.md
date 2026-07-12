# My dotfiles

```sh
# Nix
mkdir -p ~/.config/nix
ln -s ~/git/nix/nix.conf ~/.config/nix/nix.conf

# Home Manager
ln -s ~/git/nix/home-manager ~/.config/home-manager
nix run home-manager/release-26.05 -- switch --flake ~/.config/home-manager
```
