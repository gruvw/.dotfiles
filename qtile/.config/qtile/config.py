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


class Commands:
    vifm = f"{terminal} vifm"
    vim_anywhere = home + "/pathed/vim-anywhere"

    vscode = "code"

    # TODO do it for every possible device
    amixer_prefix = "amixer -D pulse sset"
    audio_increase = f"{amixer_prefix} Master 5%+"
    audio_decrease = f"{amixer_prefix} Master 5%-"
    audio_mute_toggle = f"{amixer_prefix} Master toggle"
    microphone_mute_toggle = f"{amixer_prefix} Capture toggle"

    playerctl_prefix = "playerctl"
    music_pause = f"{playerctl_prefix} play-pause"
    music_next = f"{playerctl_prefix} next"
    music_previous = f"{playerctl_prefix} previous"

    lock_screen = "betterlockscreen -l"

    brightness_prefix = "/pathed/brightness"
    brightness_increase = home + f"{brightness_prefix} +"
    brightness_decrease = home + f"{brightness_prefix} -"

    screenshot_fullscreen = "gnome-screenshot"
    screenshot_area = "import png:- | xclip -selection clipboard -t image/png"


class Paths:
    wallpaper_directory = home + "/SynologyDrive/Media/Images/Backgrounds/Desktop/"
    startup_script = home + "/.config/qtile/autostart.sh"


class Colors:
    bar_background = "#222222"
    text_color = "#f7f1ff"
    window_border_normal = "#222222"
    window_border_focus = "#7bd88f"
    window_floating_border_focus = "#fd9353"
    inactive_group = "#404040"
    current_group = "#7bd88f"


class Settings:
    font = "DejaVu Sans"
    font_bold = "DejaVu Sans Bold"

    widget_font_size = 14
    widget_padding = 3

    window_border_width = 3
    window_floating_border_width = 0

    wallpaper_timeout = 200

    layout_margin = 4
    bar_margin = [8, 8, 8 - layout_margin, 8]


@hook.subscribe.startup_once
def autostart():
    cycle_wallpaper()
    subprocess.Popen([Paths.startup_script])


def cycle_wallpaper():
    wallpaper = Paths.wallpaper_directory + random.choice(os.listdir(Paths.wallpaper_directory))

    for screen in qtile.screens:
        screen.cmd_set_wallpaper(wallpaper, "fill")

    qtile.call_later(Settings.wallpaper_timeout, cycle_wallpaper)


def update_margin(*args):
    group = qtile.current_screen.group
    layout = group.layout
    if layout.name == "max" or len([w for w in group.windows if not w.floating]) == 1:
        margin = [0, 0, 0, 0]
        layout.margin = 0
    else:
        margin = Settings.bar_margin
        layout.margin = Settings.layout_margin
    bar = qtile.current_screen.top
    bar._initial_margin = margin
    bar._configure(qtile, qtile.current_screen, reconfigure=True)
    bar.draw()
    group.layout_all()


hook.subscribe.layout_change(update_margin)
hook.subscribe.focus_change(update_margin)
# hook.subscribe.client_new(update_margin)
# hook.subscribe.client_killed(update_margin)


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move focus to another window"),

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
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Desktop control
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "m", lazy.next_layout(), desc="Toggle max layout"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, control], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, control], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Music
    KeyChord([mod], "s", [
        Key([], "space", lazy.spawn(Commands.music_pause), desc="Pause music"),
        Key([], "l", lazy.spawn(Commands.music_next), desc="Next song"),
        Key([], "h", lazy.spawn(Commands.music_previous), desc="Previous song"),
    ], name="Music"),

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
    Key([mod], "Escape", lazy.spawn(Commands.lock_screen), desc="Lock screen"),

    # Applications
    Key([mod], "v", lazy.spawn(Commands.vifm), desc="Launch vifm"),
    Key([mod], "semicolon", lazy.spawn(Commands.vscode), desc="Launch VSCode"),
    Key([control, alt], "v", lazy.spawn(Commands.vim_anywhere), desc="Launch vim-anywhere"),

    # Screenshot
    Key([mod], "p", lazy.spawn(Commands.screenshot_fullscreen, shell=True), desc="Full screen screenshot"),
    Key([mod, shift], "p", lazy.spawn(Commands.screenshot_area, shell=True), desc="Area screenshot"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(toggle=True),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

border_settings = dict(border_normal=Colors.window_border_normal)

layouts = [
    layout.Columns(
        **border_settings,
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

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    font=Settings.font_bold,
                    inactive=Colors.inactive_group,
                    this_current_screen_border=Colors.current_group,
                    rounded=False,
                    disable_drag=True,
                ),
                # widget.LaunchBar(progs=[
                #     ("brave-browser", "brave-browser"),
                # ]),
                widget.Prompt(),
                widget.Chord(),
                widget.Spacer(length=bar.STRETCH),
                widget.Clock(format="%Y_%m_%d %a %H:%M:%S %p"),
                widget.Spacer(length=bar.STRETCH),
                widget.ThermalZone(high=60, crit=75, format_crit="{temp}°C"),
                # widget.ThermalSensor(threshold=75, tag_sensor="Core 0"),
                widget.CPU(format="{freq_current}GHz {load_percent: >4}%"),
                widget.Memory(format="{MemUsed: .0f}{mm}"),
                # widget.Net(font="Fira Code", format="{down} ↓↑ {up}"),
                widget.Systray(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Battery(
                    format="{percent:2.0%}{char} {hour:d}:{min:02d}",
                    update_interval=5,
                    low_percentage=0.2,
                    discharge_char=""
                ),
            ],
            25,
            margin=[8, 10, 8, 10],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background=Colors.bar_background
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
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
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
