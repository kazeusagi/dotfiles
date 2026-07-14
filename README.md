# My dotfiles

## Clone repository

```sh
sudo apt update
sudo apt install -y curl xz-utils
sudo apt install -y curl xz-utils
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon

nix shell nixpkgs#git --extra-experimental-features "nix-command flakes"

mkdir -p ~/git
cd ~/git
git clone https://github.com/kazeusagi/dotfiles.git
```

## 

```sh
# Nix
## Multi user installation
sudo ln -sf ~/git/dotfiles/nix.conf /etc/nix/nix.conf

# Home Manager
sudo ln -s ~/git/dotfiles/home-manager ~/.config/home-manager
nix run home-manager/release-26.05 -- switch --flake ~/.config/home-manager

#　以降以下コマンドで反映
home-manager switch
```


# Fish

```sh
# Mac
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```
