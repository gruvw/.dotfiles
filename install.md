# Install instructions

This document facilitates the setup and installation of various programs that I use.  
It is particularly useful when configuring a new (Linux/Debian) machine.

## Basics

This part describes the first steps to do in order to come to an usual working environment.

### Initialization

(supposed current working directory `~`)

0. Host name `gruvw`, password `...`
1. Connect to wifi: `nmtui` > "Activate a connection" > ... > (restart if needed)
2. Update: `sudo apt update && sudo apt upgrade -y`
3. Install git: `sudo apt install -y git`
4. Clone dotfiles: `git clone https://github.com/gruvw/.dotfiles.git`
5. Install stow: `sudo apt install -y stow`

#### Stow

My dotfiles are organized to make use of the GNU Stow project.

Configs to stow:

```sh
cd .dotfiles
stow --no-folding -v git
stow --no-folding -v kitty
stow --no-folding -v fish
stow --no-folding -v starship
stow --no-folding -v vifm
stow --no-folding -v nvim
stow --no-folding -v vim
stow --no-folding -v qtile
stow --no-folding -v albert
stow --no-folding -v betterlockscreen
stow --no-folding -v clang
stow --no-folding -v rust
stow --no-folding -v bat
stow --no-folding -v gtk
stow --no-folding -v mpv
stow --no-folding -v hyper
cd ~
```

#### Terminal

Terminal workflow installs:

1. Kitty, <https://github.com/kovidgoyal/kitty>
2. Fish Shell, <https://github.com/fish-shell/fish-shell>
3. VIFM, <https://github.com/vifm/vifm>
4. Bat, <https://github.com/sharkdp/bat#on-ubuntu-using-apt>
5. Starship prompt > y, <https://github.com/starship/starship>

```sh
sudo apt install -y kitty
sudo apt install -y fish
sudo apt install -y vifm
sudo apt install -y bat
sudo apt install -y curl
curl -sS https://starship.rs/install.sh | sh
```

4. Fira Code + Nerd Font, <https://github.com/tonsky/FiraCode> + <https://github.com/ryanoasis/nerd-fonts/releases>

```sh
mkdir -p Downloads/fonts
cd Downloads/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
wget -q https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
sudo apt install -y unzip
unzip -d FiraCode Fira_Code_v6.2.zip
unzip -d FiraCodeNF FiraCode.zip
mkdir ~/.fonts
cd FiraCodeNF
cp *.ttf ~/.fonts
cd ../FiraCode/ttf
cp *.ttf ~/.fonts
cd ~
fc-cache -fv
```

5. NeoVim, <https://github.com/neovim/neovim>

```sh
mkdir -p Downloads/neovim
cd Downloads/neovim
wget -q https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
cd nvim-linux64/bin
mkdir ~/pathed
cp nvim ~/pathed
cd ~
```

6. Fix PATH

```sh
echo 'export PATH="$HOME/pathed:$PATH"' >> .bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> .bashrc
```

#### Desktop environment

Setup basic desktop software.

1. Python 3.11 > Enter

```sh
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.11
sudo apt install -y python3-pip
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
```

2. Qtile, <https://docs.qtile.org/en/latest/manual/install/ubuntu.html>, <https://www.reddit.com/r/qtile/comments/1605sf5/qtile_not_startingrunning_qtile/>

```sh
pip install xcffib
pip install --no-build-isolation git+https://github.com/qtile/qtile.git
```

3. Albert, <https://albertlauncher.github.io/installing/>, <https://software.opensuse.org/download.html?project=home:manuelschneid3r&package=albert>

```sh
cd Downloads
wget -q https://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_22.04/amd64/albert_0.22.4-0+567.1_amd64.deb
sudo dpkg -i albert_0.22.4-0+567.1_amd64.deb
sudo apt -f -y install
cd ~
```

4. Betterlockscreen, <https://github.com/betterlockscreen/betterlockscreen#manual-installation>

```sh
mkdir -p Downloads/BLS
cd Downloads/BLS
wget -q https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
sudo apt install -y unzip
unzip -d BLS main.zip
cd BLS/betterlockscreen-main
sudo chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/
sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable betterlockscreen@$USER
cd ~
```

## Recommended

You can now reboot your system and login from Qtile WM.

The following are recommended installs.

### Brave Browser

+ extensions

### Synology Drive

### VSCode
