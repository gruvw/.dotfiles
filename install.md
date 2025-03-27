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

```
sudo apt install ninja-build gettext cmake curl build-essential
```

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

Build/install from source: <https://github.com/neovim/neovim/blob/master/BUILD.md>

Or use appimage:

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
sudo chmod u+x pathed/vim-anywhere
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
pip install xcffib autorandr
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
sudo apt install -y feh
sudo apt install -y imagemagick
unzip -d BLS main.zip
cd BLS/betterlockscreen-main
sudo chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/
sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable betterlockscreen@$USER
cd ~
```

Install i3lock-color: follow <https://github.com/Raymo111/i3lock-color>

5. Other desktop (picom, numix-icon, copyq)

```sh
sudo apt install -y picom
sudo apt install -y numix-icon-theme-circle
sudo apt install -y copyq
sudo apt install -y hollywood
```

6. Natural scrolling, do <https://forum.endeavouros.com/t/natural-scrolling-on-mouse-and-track-pad/15121/8> (add TouchPad)

## Recommended

You can now reboot your system and login from Qtile WM.

The following are recommended installs.

### NeoVim

Finish NeoVim config: open NeoVim twice (let time to install plugins and packages)

Install `jsregexp` from `LuaSnip`:

```sh
cd ~/.local/share/nvim/lazy/LuaSnip
make install_jsregexp
cd ~
```

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
* Video Speed Controller: https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk
* GoFullPage: https://chrome.google.com/webstore/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl

### Icons

Open and download the "all-version" release of the following:

* Simp1e Cursors: <https://www.pling.com/p/1932768> > Extract content to `~/.icons/`
* Yaru-Colors: <https://www.gnome-look.org/p/1299514> > Execute `install.sh`, follow install instructions (launch gnome to install shell extension)

### Synology Drive

Install: <https://www.synology.com/fr-fr/support/download> > NAS > DS220j > Desktop Utilities > Synology Drive Client > Ubuntu

```sh
cd Downloads
sudo dpkg -i synology-drive-client-version.deb
cd ~
```

1. Launch Synology Drive
2. Connect and login
3. Select Sync Task
4. Select NAS folder `/Lucas`
5. Start sync
6. Pause sync
7. Settings > Notifications > Desktop Notifications > Disable > Apply
8. Go to `~/.SynologyDrive/data/session/1/conf/` (maybe not exact)
9. `sudo rm blacklist.filter`
10. `sudo ln ~/.dotfiles/others/synology/blacklist.filter`
11. Resume sync

Set lockscreen wallpaper once synced: `betterlockscreen -u SynologyDrive/Media/Images/Backgrounds/Desktop/wallhaven-x8ye3z.jpg`

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

## Optional

Other software.

### Flutter

<https://ubuntu.com/blog/getting-started-with-flutter-on-ubuntu>, <https://docs.flutter.dev/get-started/install/linux>

* Dependencies: `sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
`
* Install: `sudo snap install flutter --classic`
* Alias: `sudo snap alias flutter.dart dart`
* Check `flutter doctor`
* Telemetry: `flutter --disable-telemetry`
* Android studio: `sudo snap install android-studio --classic`
* Android install: `android-studio`
* Path: `flutter config --android-studio-dir /snap/android-studio/current/android-studio`
* SKDManager: <https://stackoverflow.com/a/62914315>
* cmdline-tools: <https://stackoverflow.com/questions/60475481/flutter-doctor-error-android-sdkmanager-tool-not-found-windows>
* Licenses: `flutter doctor --android-licenses`

### Others APT

```sh
sudo apt install -y libgtk-3-dev
sudo apt install -y lcov
sudo apt install -y meshlab
sudo apt install -y clang
sudo apt install -y clang-tools
sudo apt install -y playerctl
sudo apt install -y ruby-dev
sudo apt install -y ruby-bundler
sudo apt install -y secure-delete
sudo apt install -y plocate
sudo apt install -y fzf
sudo apt install -y blueman
sudo apt install -y libreoffice
sudo apt install -y stress
sudo apt install -y openssh-client
sudo apt install -y network-manager
sudo apt install -y net-tools
sudo apt install -y ghdl
sudo apt install -y pavucontrol
sudo apt install -y nemo
sudo apt install -y gdebi
sudo apt install -y blender
sudo apt install -y mpv
sudo apt install -y libfuse2
sudo apt install -y xclip
sudo apt install -y ripgrep
sudo apt install -y cloc
sudo apt install -y openjdk-17-jre
sudo apt install -y openjdk-19-jre
sudo apt install -y ccrypt
sudo apt install -y texlive-full texlive
sudo apt install -y transmission
sudo apt install -y peek
sudo apt install -y okteta
sudo apt install -y neofetch
sudo apt install -y vlc
sudo apt install -y gparted
sudo apt install -y sqlitebrowser
sudo apt install -y gimp
sudo apt install -y geary
sudo apt install -y baobab
sudo apt install -y gnome-usage
sudo apt install -y chrome-gnome-shell
sudo apt install -y gnome-shell-extensions
sudo apt install -y vim
sudo apt install -y gnome-tweaks
sudo apt install -y clangd clang-tidy clang-format
sudo apt install -y nomacs
sudo apt install -y exiftool
sudo apt install -y jpegoptim
sudo apt install -y flatpack
sudo apt install -y xdotool
```

### Other programs

Pinta: <https://github.com/PintaProject/Pinta>
Scrcpy: <https://github.com/Genymobile/scrcpy>

```sh
sudo snap install pinta
sudo snap install scrcpy
```

### Dragon

Install: <https://github.com/mwh/dragon>

```sh
cd Downloads
git clone https://github.com/mwh/dragon
cd dragon
make install
cd ~
```

### Rust + cargo

<https://doc.rust-lang.org/cargo/getting-started/installation.html>

* Comment sccache line in `~/.cargo/config.toml`

```sh
curl https://sh.rustup.rs -sSf | sh
cargo install sccache --locked
```

* Un-comment sccache line in `~/.cargo/config.toml`

### Cargo tools

* Cargo update: <https://crates.io/crates/cargo-update>
* Bottom (btm): <https://github.com/ClementTsang/bottom>

```sh
cargo install cargo-update
cargo install bottom --locked
```

### Figma

```sh
sudo snap install figma-linux
```

### Mailspring

* Download deb: <https://github.com/Foundry376/Mailspring/releases>
* Install: `sudo dkpg -i mailspring-version.deb`
* Fix dependencies: `sudo apt -f -y install`
* Open and setup every email (need application specific passwords to be generated)

### Rambox / Hamsek

<https://github.com/TheGoddessInari/hamsket>

```sh
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install -y appimagelauncher
```

* Download appimage from release and install it.
* Connect accounts

### Java Libs

#### JavaFx Sdk

<https://openjfx.io/>

* Download
* Exctract to `~/libs/`

#### Junit

<https://jar-download.com/artifacts/org.junit.platform/junit-platform-console-standalone/1.8.2/source-code>

* Download platform console standalone JAR
* Exctract to `~/libs/junit-1.8.2/`

#### JDTLS

<https://github.com/eclipse-jdtls/eclipse.jdt.ls>, <https://github.com/mfussenegger/nvim-jdtls>

* Download here: <https://download.eclipse.org/jdtls/milestones/?d>
* Extract to `~/libs/jdtls/`

### Python packages

```sh
pip install cookiecutter
pip install mypy
```

### Quartus

* Download and install: <https://www.intel.com/content/www/us/en/software-kit/785085/intel-quartus-prime-lite-edition-design-software-version-22-1-2-for-linux.html> > version 21.1.1 > Individual files > QuartusLite Setup
* USB Blaster: <https://www.rocketboards.org/foswiki/Documentation/UsingUSBBlasterUnderLinux>

### Others

* LazyGit: <https://github.com/jesseduffield/lazygit#ubuntu>

#### Cargo applications

* Bottom: <https://github.com/ClementTsang/bottom>
* Bat: <https://github.com/sharkdp/bat>
* Delta: <https://github.com/dandavison/delta>

```
cargo install bottom
cargo install --locked bat
cargo install git-delta
```

#### Aseprite

* Go to purshase link in saved emails (search "Aseprite" or "noreply@humblebundle.com").
* Platform Linux > Direct Link > 64-bit
* Place download to `~/Downloads`

```sh
cd ~/Downloads
sudo apt install ./Aseprite_*.deb
```

#### OBS Studio

* Download `.deb` from <https://github.com/obsproject/obs-studio/releases>

```sh
cd ~/Downloads
sudo apt install ./OBS-Studio-*.deb
```

#### Jupyter NoteBook

* See <https://jupyter.org/install>

```sh
pip install jupyterlab notebook
```

#### Arduino CLI

Don't install from snap as it will not install latest version and fail with Neovim LSP

* See <https://github.com/arduino/arduino-cli>
* See <https://arduino.github.io/arduino-cli/0.35/installation/>

#### Go lang

Follow <https://go.dev/doc/install>.
