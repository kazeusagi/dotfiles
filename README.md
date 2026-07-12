# dotfiles

## 環境構築

```sh
# Nixのインストール
sudo apt update
sudo apt install curl xz-utils
# シングルユーザーインストール: https://nixos.org/download/
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --no-daemon

# クローン
nix shell nixpkgs#git --extra-experimental-features "nix-command flakes"
git clone https://github.com/kazeusagi/nix.git
```

## クローン後

```sh
# Nix
mkdir -p ~/.config/nix
ln -s ~/git/nix/nix.conf ~/.config/nix/nix.conf

# Home Manager
ln -s ~/git/nix/home-manager ~/.config/home-manager
nix run home-manager/release-26.05 -- switch --flake ~/.config/home-manager
```
