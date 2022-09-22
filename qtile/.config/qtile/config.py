# ~/.config/qtile/config.py

import os
import random
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy


terminal = "kitty"
mod, shift, control, alt = "mod4", "shift", "control", "mod1"

# TODO remove /home/gruvw/pathed and make it to the path


class Commands:
    vifm = f"{terminal} vifm"
    vim_anywhere = "/home/gruvw/pathed/vim-anywhere"

    # TODO do it for every possible device
    audio_increase = "amixer -D pulse sset Master 5%+"
    audio_decrease = "amixer -D pulse sset Master 5%-"
    audio_mute_toggle = "amixer -D pulse sset Master toggle"
    microphone_mute_toggle = "amixer -D pulse set Capture toggle"

    lock_screen = "betterlockscreen -l"

    brightness_increase = "/home/gruvw/pathed/brightness +"
    brightness_decrease = "/home/gruvw/pathed/brightness -"

    screenshot_fullscreen = "gnome-screenshot"
    screenshot_area = "gnome-screenshot -a"


class Paths:
    wallpaper_directory = "~/SynologyDrive/Media/Images/Backgrounds/Desktop/"
    auto_start = "~/.config/qtile/autostart.sh"


class Colors:
    window_border_normal = "#222222"
    window_border_focus = "#7bd88f"
    window_floating_border_focus = "#fd9353"


class Settings:
    font = "sans"

    widget_font_size = 12
    widget_padding = 3

    window_border_width = 3
    window_floating_border_width = 0


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move focus to another window"),

    # Move windows (moving out of range in Columns layout will create new column)
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow/Shrink windows
    Key([mod, control], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, control], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, control], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, control], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Desktop control
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "m", lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, control], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, control], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Special keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn(Commands.audio_increase), desc="Increase audio volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(Commands.audio_decrease), desc="Lower audio volume"),
    Key([], "XF86AudioMute", lazy.spawn(Commands.audio_mute_toggle), desc="Toggle audio mute/unmute"),

    Key([], "XF86AudioMicMute", lazy.spawn(Commands.microphone_mute_toggle), desc="Toggle microphone mute/unmute"),

    Key([], "XF86MonBrightnessUp", lazy.spawn(Commands.brightness_increase), desc="Increase screen brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(Commands.brightness_decrease), desc="Lower screen brightness"),

    # Launch
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Escape", lazy.spawn(Commands.lock_screen), desc="Lock screen"),
    Key([mod], "v", lazy.spawn(Commands.vifm), desc="Launch vifm"),
    Key([control, alt], "v", lazy.spawn(Commands.vim_anywhere), desc="Launch vim-anywhere"),
    Key([mod], "p", lazy.spawn(Commands.screenshot_fullscreen), desc="Full screen screenshot"),
    Key([mod, shift], "p", lazy.spawn(Commands.screenshot_area), desc="Area screenshot"),
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
        border_width=Settings.window_border_width
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
        wallpaper=Paths.wallpaper_directory + random.choice(os.listdir(os.path.expanduser(Paths.wallpaper_directory))),
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Battery(format="{char} {percent:2.0%} {hour:d}:{min:02d}"),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
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


# Autostart
@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser(Paths.auto_start)
    subprocess.Popen([script])
