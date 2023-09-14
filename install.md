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
stow --no-folding -v x
stow --no-folding -v qtile
stow --no-folding -v albert
stow --no-folding -v copyq
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
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
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

5. NeoVim, <https://github.com/neovim/neovim/wiki/Installing-Neovim>

```sh
sudo apt install -y nodejs npm
mkdir -p Downloads/neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo ./nvim.appimage --appimage-extract
sudo ./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
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

2. Qtile, <https://docs.qtile.org/en/latest/manual/install/ubuntu.html>, <https://www.reddit.com/r/qtile/comments/1605sf5/qtile_not_startingrunning_qtile/>, <https://github.com/qtile/qtile/issues/1849>

```sh
pip install xcffib
pip install --no-build-isolation git+https://github.com/qtile/qtile.git
cd /usr/share/xsessions/
sudo ln ~/.dotfiles/others/qtile/qtile.desktop
pip install dbus-next psutil
cd ~
```

3. Albert, <https://albertlauncher.github.io/installing/>, <https://software.opensuse.org/download.html?project=home:manuelschneid3r&package=albert>

```sh
cd Downloads
wget https://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/amd64/albert_0.17.6-0_amd64.deb
sudo dpkg -i albert_0.17.6-0_amd64.deb
sudo apt -f -y install
sudo mkdir -p /usr/share/albert/org.albert.frontend.widgetboxmodel/themes
cd /usr/share/albert/org.albert.frontend.widgetboxmodel/themes
sudo ln ~/.dotfiles/others/albert/gruvw.qss
cd ~
```

4. Betterlockscreen, <https://github.com/betterlockscreen/betterlockscreen#manual-installation>

```sh
mkdir -p Downloads/BLS
cd Downloads/BLS
wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
sudo apt install -y unzip
unzip -d BLS main.zip
cd BLS/betterlockscreen-main
sudo chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/
sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable betterlockscreen@$USER
cd ~
```

5. Other desktop (picom, numix-icon, copyq)

```sh
sudo apt install -y picom
sudo apt install -y numix-icon-theme-circle
sudo apt install -y copyq
```

6. Natural scrolling, do <https://forum.endeavouros.com/t/natural-scrolling-on-mouse-and-track-pad/15121/8> (add TouchPad)

## Recommended

You can now reboot your system and login from Qtile WM.

The following are recommended installs.

### NeoVim

Finish NeoVim config: open NeoVim twice (let time to install plugins and packages)

### Brave Browser

<https://brave.com/linux/>

```sh
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
```

#### Settings

1. Right Click Brave rewards > Hide
2. Right Click Brave wallet > Hide
3. Right Click Side bar icon > Hide
4. Settings
    1. Appearance
        1. Brave colors > dark
        2. Theme > GTK
        3. Brave news > Disable
        4. Use wide address bar > Enable
        5. Always show full urls > Enable
        6. Show Tab Search > Disable
    2. Privacy > https://forum.endeavouros.com/t/natural-scrolling-on-mouse-and-track-pad/15121/8
    3. Search engine
       1. Normal Window > Google
       2. Private Window > DuckDuckGo
       3. Improve search Suggestions > Enable
    4. AutoFill and passwords
       1. Payments > Disable All
       2. Addresses > Disable

#### Browser extensions

* TabCopy: https://chrome.google.com/webstore/detail/tabcopy/micdllihgoppmejpecmkilggmaagfdmb
* BitWarden: https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
* Raindrop.io: https://chrome.google.com/webstore/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien
* Buster: https://chrome.google.com/webstore/detail/buster-captcha-solver-for/mpbjkejclgfgadiemmefgebjfooflfhl
* ClearURLs: https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk
* GA out out: https://chrome.google.com/webstore/detail/google-analytics-opt-out/fllaojicojecljbmefodhfapmkghcbnh
* Language Tool: https://chrome.google.com/webstore/detail/grammar-checker-paraphras/oldceeleldhonbafppcapldpdifcinji
* IDC about cookies: https://chrome.google.com/webstore/detail/i-dont-care-about-cookies/fihnjjcciajhdojfnbdddfaoknhalnja
* Image downloader: https://chrome.google.com/webstore/detail/image-downloader/cnpniohnfphhjihaiiggeabnkjhpaldj
* uBlock Origin: https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
* Video Downloader Pro: https://chrome.google.com/webstore/detail/video-downloader-professi/elicpjhcidhpjomhibiffojpinpmmpil
* Video DownloadHelper: https://chrome.google.com/webstore/detail/video-downloadhelper/lmjnegcaeklhafolokijcfjliaokphfk
* Video Speed Controller: https://chrome.google.com/webstore/detail/video-speed-controller/ohohfdnookdcdddlkponhlbeeknjbpik
* GoFullPage: https://chrome.google.com/webstore/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl

### Icons

Open and download the "all-version" release of the following:

* Simp1e Cursors: <https://www.pling.com/p/1932768>
* Yaru-Colors: <https://www.gnome-look.org/p/1299514>

Extract content to `~/.icons/`.

### Synology Drive

Install: <https://www.synology.com/fr-fr/support/download> > NAS > DS220j > Desktop Utilities > Synology Drive Client > Ubuntu

```sh
cd Downloads
sudo dpkg -i synology-drive-client-version.deb
cd ~
```

### VSCode

Install: <https://code.visualstudio.com/docs/?dv=linux64_deb>

```sh
cd Downloads
sudo dpkg -i code_version.dev
cd ~
```

* Connect with GitHub
* Sync Settings
* Close an Reopen
* Check extensions & User Settings
