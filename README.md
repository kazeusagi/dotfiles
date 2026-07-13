# My dotfiles

```sh
# Nix
## Multi user installation
ln -sf ~/git/dotfiles/nix.conf /etc/nix/nix.conf

## Single user installation
mkdir -p ~/.config/nix
ln -s ~/git/nix/nix.conf ~/.config/nix/nix.conf

# Home Manager
ln -s ~/git/dotfiles/home-manager ~/.config/home-manager
nix run home-manager/release-26.05 -- switch --flake ~/.config/home-manager
```


# Fish

```sh
# Mac
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```
