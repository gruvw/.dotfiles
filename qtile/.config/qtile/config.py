# ~/.config/qtile/config.py

import os
import random
import subprocess

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy


terminal = "kitty"
mod, shift, control, alt = "mod4", "shift", "control", "mod1"

home = os.path.expanduser("~")


class Paths:
    brightness_prefix = "/pathed/brightness"
    wallpaper_directory = home + "/SynologyDrive/Media/Images/Backgrounds/Desktop/"
    startup_script = home + "/.config/qtile/autostart.sh"
    vim_anywhere = home + "/pathed/vim-anywhere"


class Commands:
    file_manager = f"{terminal} vifm"
    text_editor = f"{terminal} nvim"
    process_manager = f"{terminal} btm"
    ide = "code"

    # TODO do it for every possible device
    amixer_prefix = "amixer -D pulse sset"
    audio_increase = f"{amixer_prefix} Master 5%+"
    audio_decrease = f"{amixer_prefix} Master 5%-"
    audio_mute_toggle = f"{amixer_prefix} Master toggle"
    microphone_mute_toggle = f"{amixer_prefix} Capture toggle"

    albert = "albert show"

    music_open = f"spotify"
    playerctl_prefix = "playerctl"
    music_pause = f"{playerctl_prefix} play-pause"
    music_next = f"{playerctl_prefix} next"
    music_previous = f"{playerctl_prefix} previous"

    lock_screen = "betterlockscreen -l"

    brightness_increase = "brightnessctl s 10%+"
    brightness_decrease = "brightnessctl s 10%-"

    screenshot_fullscreen = "gnome-screenshot"
    screenshot_area = "import png:- | xclip -selection clipboard -t image/png"


class Keyboard:
    layout_prefix = "setxkbmap"
    layout_caps_bs = "-option caps:backspace"
    layout_compose = "" # TODO fix not working: ;xmodmap -e 'keycode 108 = Multi_key'
    layout_dvorak = f"{layout_prefix} dvorak {layout_caps_bs} {layout_compose}"
    layout_us = f"{layout_prefix} us {layout_compose}"


class Colors:
    bar_background = "#1F1F1F"
    text_color = "#F4F4F4"
    window_border_normal = "#1F1F1F"
    window_border_focus = "#69FC9A"
    window_floating_border_focus = "#FC9A69"
    inactive_group = "#757575"
    current_group = "#69FC9A"


class Settings:
    font = "FiraCode Nerd Font"
    font_bold = "FiraCode Nerd Font Bold"

    widget_font_size = 22
    widget_padding = 6

    window_border_width = 3
    window_floating_border_width = 0

    wallpaper_timeout = 200

    bar_margin = [0] * 4


@hook.subscribe.startup_once
def autostart():
    cycle_wallpaper()
    subprocess.Popen([Paths.startup_script])
    pass


def cycle_wallpaper():
    wallpaper = Paths.wallpaper_directory + random.choice(os.listdir(Paths.wallpaper_directory))

    for screen in qtile.screens:
        screen.cmd_set_wallpaper(wallpaper, "fill")

    qtile.call_later(Settings.wallpaper_timeout, cycle_wallpaper)

keys: list = []  # Initialize + avoid warning

groups = [Group(str(i)) for i in range(10)]

for g in groups:
    keys += [
        # mod1 + letter of group = switch to group
        Key(
            [mod],
            g.name,
            lazy.group[g.name].toscreen(toggle=True),
            desc="Switch to group {}".format(g.name),
        ),
        # mod1 + shift + letter of group = switch to & move focused window to group
        Key(
            [mod, shift],
            g.name,
            lazy.window.togroup(g.name, switch_group=True),
            desc=f"Switch to & move focused window to group {g.name}",
        ),
        Key(
            [mod, control],
            g.name,
            lazy.window.togroup(g.name),
            desc=f"Move focused window to group {g.name} (no group switch)",
        ),
    ]

keys += [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move focus to another window"),

    # Move windows (moving out of range in Columns layout will create new column)
    Key([mod, shift], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, shift], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, shift], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, shift], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow/Shrink windows
    Key([mod, control], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, control], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, control], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, control], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Move to screen
    Key([mod], "Right", lazy.next_screen(), desc=""),

    # More group related keys
    KeyChord([mod], "g", [
        # Key([gi.name], gj.name, swap_groups(i, gi, j, gj),
        #     desc=f"Swaps windows between {gi.name} and {gj.name}")
        # for (i, gi) in enumerate(groups) for (j, gj) in enumerate(groups) if gi.name != gj.name
    ], name="group"),

    # Desktop control
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "m", lazy.next_layout(), desc="Next layout"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, control], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, control], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Keyboard
    KeyChord([mod], "a", [
        Key([], "u", lazy.spawn(Keyboard.layout_us), desc="Keyboard layout to US"),
        Key([], "d", lazy.spawn(Keyboard.layout_dvorak), desc="Keyboard layout to DVORAK"),
    ], name="keyboard"),

    # Music
    KeyChord([mod], "s", [
        Key([], "Return", lazy.spawn(Commands.music_open), desc="Open music app"),
        Key([], "space", lazy.spawn(Commands.music_pause), desc="Pause music"),
        Key([], "l", lazy.spawn(Commands.music_next), desc="Next song"),
        Key([], "h", lazy.spawn(Commands.music_previous), desc="Previous song"),
    ], name="music"),

    # Special keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn(Commands.audio_increase), desc="Increase audio volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(Commands.audio_decrease), desc="Lower audio volume"),
    Key([], "XF86AudioMute", lazy.spawn(Commands.audio_mute_toggle), desc="Toggle audio mute/unmute"),

    Key([], "XF86AudioMicMute", lazy.spawn(Commands.microphone_mute_toggle), desc="Toggle microphone mute/unmute"),

    Key([], "XF86MonBrightnessUp", lazy.spawn(Commands.brightness_increase), desc="Increase screen brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(Commands.brightness_decrease), desc="Lower screen brightness"),

    # Launch
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, shift], "Return", lazy.spawncmd(prompt="cmd"), desc="Spawn a command using the prompt widget"),
    Key([mod], "u", lazy.spawn(Commands.albert), desc="Show albert prompt"),
    Key([mod], "Escape", lazy.spawn(Commands.lock_screen), desc="Lock screen"),

    # Applications
    Key([mod], "v", lazy.spawn(Commands.file_manager), desc="Launch file manager"),
    Key([mod], "n", lazy.spawn(Commands.text_editor), desc="Launch text editor"),
    Key([mod], "semicolon", lazy.spawn(Commands.ide), desc="Launch IDE"),
    Key([mod], "b", lazy.spawn(Commands.process_manager), desc="Launch process manager"),
    Key([control, alt], "v", lazy.spawn(Paths.vim_anywhere), desc="Launch vim-anywhere"),

    # Screenshot
    Key([mod], "p", lazy.spawn(Commands.screenshot_fullscreen, shell=True), desc="Full screen screenshot"),
    Key([mod, shift], "p", lazy.spawn(Commands.screenshot_area, shell=True), desc="Area screenshot"),
]

border_settings = dict(border_normal=Colors.window_border_normal)

layouts = [
    layout.Columns(
        **border_settings,
        name="col",
        border_focus=Colors.window_border_focus,
        border_width=Settings.window_border_width,
        wrap_focus_columns=False
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font=Settings.font,
    fontsize=Settings.widget_font_size,
    padding=Settings.widget_padding,
)
extension_defaults = widget_defaults.copy()

SEPARATOR = widget.Sep(size_percent=73, padding=8, linewidth=1)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    font=Settings.font_bold,
                    inactive=Colors.inactive_group,
                    this_current_screen_border=Colors.current_group,
                    this_screen_border=[4]*4,
                    rounded=False,
                    disable_drag=True,
                ),
                widget.Prompt(),
                widget.Chord(
                    font=Settings.font_bold,
                    background="f7f1ff",
                    foreground="363537",
                    name_transform=lambda name: name.upper(),
                    padding=4,
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.Clock(format="%Y_%m_%d %a %H:%M:%S %p"),
                widget.Spacer(length=bar.STRETCH),
                # widget.Wlan(),
                widget.Net(format="{down:03.0f}{down_suffix:<2} D {up:03.0f}{up_suffix:<2} U"),
                SEPARATOR,
                widget.ThermalZone(high=70, crit=85, format_crit="{temp}°C"),
                # widget.ThermalSensor(threshold=75, tag_sensor="Core 0"),
                widget.CPU(format="{freq_current}GHz {load_percent: >4}%"),
                widget.Memory(format="{MemUsed: .0f}{mm}"),
                SEPARATOR,
                widget.Volume(
                    emoji=True,
                    emoji_list=["M", "1", "2", "3"],
                ),
                SEPARATOR,
                widget.Systray(icon_size=28),
                SEPARATOR,
                widget.Battery(
                    format="{percent:2.0%}{char} {hour:d}:{min:02d}",
                    update_interval=5,
                    low_percentage=0.2,
                    discharge_char=""
                ),
            ],
            40,
            margin=Settings.bar_margin,
            # border_width=[0, 0, 1, 0],
            border_color=[Colors.text_color] * 4,
            background=Colors.bar_background
        ),
    ),
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod, control], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    **border_settings,
    border_focus=Colors.window_floating_border_focus,
    border_width=Settings.window_floating_border_width,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="albert"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
