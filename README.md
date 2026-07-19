# My dotfiles

## Clone repository

```sh
# Nixのインストール
sudo apt update
sudo apt install -y curl xz-utils
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
# Git環境の起動
nix shell nixpkgs#git --extra-experimental-features "nix-command flakes"
# HTTPSでクローン
mkdir -p ~/git
cd ~/git
git clone https://github.com/kazeusagi/dotfiles.git

exit
```

## Nix環境の初期化

```sh
# nix.conf
## Multi user installation
sudo ln -sf ~/git/dotfiles/nix.conf /etc/nix/nix.conf
## Single user installation
mkdir -p ~/.config/nix
ln -s ~/git/nix/nix.conf ~/.config/nix/nix.conf

# Home Manager
ln -s ~/git/dotfiles/home-manager ~/.config/home-manager
nix run home-manager/release-26.05 -- switch --flake ~/.config/home-manager

#　以降以下コマンドで反映
home-manager switch
```

# デフォルトシェルをfishにする

```sh
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```

## SSH Agent

### Windows

```sh
winget install albertony.npiperelay
Get-Command npiperelay
# 出力先が `win.nix` のEXECパスと一致することを確認

ssh-add -l
ssh -T git@github.com
# GitへのアクセスをSSH経由にする
git remote set-url origin git@github.com:kazeusagi/dotfiles.git
```

```sh
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/win32yank.exe
sudo chmod +x /usr/local/bin/win32yank.exe
```
