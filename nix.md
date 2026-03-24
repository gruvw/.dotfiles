# NixOS Roadmap

## Programs

- [x] Main
    - [x] Git
    - [x] Kitty
    - [x] Fish
    - [x] Starship
    - [x] VIFM
    - [x] Niri
    - [x] FiraCode
    - [x] Waybar
    - [x] Brave browser
        - [x] Brave extensions
        - [x] Brave settings
    - [x] Neovim
    - [x] Albert launcher
        - [x] Custom theme
        - [x] Custom search
        - [x] Open browser items on new tab
    - [x] VLC
    - [x] Libre Office

- [x] Messaging
    - [x] Thunderbird
        - [x] Thunderbird config
    - [x] Whatsapp web
    - [x] Telegram web
    - [x] Discord web
    - [x] Signal

- [x] Development
    - [x] Python
    - [x] Jupyter Notebook
    - [x] Flutter & Android SDK
    - [x] Golang
    - [x] Arduino IDE
    - [x] arduino-ci
    - [x] Typst

- [x] Tools
    - [x] Ripgrep
    - [x] Cloc
    - [x] Zola
    - [x] Sqlite browser
    - [x] Ccrypt
    - [x] Qbit torrent

- [x] Photo / Video / 3D
    - [x] Gimp
    - [x] Aseprite
    - [x] OBS
    - [x] Kooha
    - [x] Nomacs
    - [x] Orca slicer
    - [x] Blender

- [x] Others
    - [x] Hollywood

## Config

- [ ] Niri
    - [ ] Waybar config
        - [x] Workspaces
        - [x] Time date
        - [x] CPU
        - [x] Temperature
        - [x] Memory
        - [x] Network
        - [x] Systray
        - [x] Battery + time
        - [x] Brightness state
        - [x] Volume state
        - [x] Mic state
        - [ ] Style and states (spacing, separators?)
    - [x] Show/Hide help commands (hide on startup)
    - [x] Lockscreen
        - [x] Time date
        - [x] Password field
        - [ ] Background ?
    - [x] Top keys (brightness, sound, etc)
    - [x] Browser focus urls xdg-open
    - [x] Custom cursor
    - [ ] Backgrounds (rotating)
    - [ ] Scherlock or Anyrun launcher
- [x] ESP 32 IDF Rust nix shell development
- [ ] Extract all dotfiles (niri, nix, gtklock, waybar, albert)
- [ ] Use flakes
- [ ] Garbage collection, automatic
- [ ] Brave settings configuration
- [ ] Brave/Chrome extensions
- [x] GitHub login (gh cli)
    - [x] GPG keys to sign
- [ ] Neovim
    - [ ] LSP support
        - [x] Rust (+ embedded esp 32)
    - [ ] Treesitter languages
    - [ ] Setup neovim SQLite library file for clipboard
- [ ] Synology drive
- [ ] Nix to github, flakes?, profiles?

- [ ] Home manager
    - [ ] Git repository setup
    - [ ] Neovim
        - [ ] Install LSPs without mason
    - [ ] Brave settings configuration
    - [ ] Brave extensions
    - [ ] Thunderbird
    - [ ] Synology drive
    - [ ] Transition from gnu stow
    - [ ] Secrets storage (GitHub git, Brave logins / cookies, Bitwarden)

## Additionnal

- [ ] NuShell

## Other procedures

- Set cursor

```
gsettings set org.gnome.desktop.interface cursor-theme "Simp1e"
gsettings set org.gnome.desktop.interface cursor-size 22
```

- Install `jsregexp` from `LuaSnip`
