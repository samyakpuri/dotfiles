
# General Imports
import os
import subprocess

# qtile imports
from libqtile.config import KeyChord, Key
from libqtile.lazy import lazy
from libqtile.utils import describe_attributes

# EzKey style simpification
mod = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

terminal = os.getenv("TERMINAL")
browser = os.getenv("BROWSER")
launcher = "rofi -show drun"

# Keys for workspaces and layouts Other in sxhd
keys = [
    # Super + Keys 
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "a", lazy.to_screen(1), desc="Keyboard focus to monitor 1"),
    Key([mod], "s", lazy.to_screen(0), desc="Keyboard focus to monitor 2"),
    Key([mod], "period", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([mod], "comma", lazy.prev_screen(), desc="Move focus to prev monitor"),

    # Super + Shift
    Key([mod, shift], "x", lazy.shutdown(),desc="Quit qtile"),
    Key([mod], "F2", lazy.restart(), desc="Restart qtile"),

    # Qtile Layout Keys
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize layout"),
    Key([mod], "t", lazy.next_layout(), desc="Tab between Layouts"),

    # Change Focus
    Key([mod], "k", lazy.layout.up(), desc="Focus up"),
    Key([mod], "j", lazy.layout.down(), desc="Focus down"),
    Key([mod], "h", lazy.layout.left(), desc="Focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Focus right"),

    # Resize
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Resize increase to right"
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Resize increase to left"
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Resize increase up"
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Resize increase down"
    ),

    # Flip Layout For Monadtall/Monadwide
    Key([mod, "shift"], "f", lazy.layout.flip(), desc="Monadtall Flip sides"),

    # Flip Layout For Bsp
    Key([mod, "mod1"], "k", lazy.layout.flip_up(), desc="BSP change to up"),
    Key([mod, "mod1"], "j", lazy.layout.flip_down(), desc="BSP change to down"),
    Key([mod, "mod1"], "l", lazy.layout.flip_right(), desc="BSP change to right"),
    Key([mod, "mod1"], "h", lazy.layout.flip_left(), desc="BSP change to left"),

    # Move Windows Up Or Down Bsp Layout
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="BSP Move window up"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="BSP Move window down"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="BSP Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="BSP Move window right"),

    # Move Windows Up Or Down Monadtall/Monadwide Layout
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Monadtall move window Up"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Monadtall move window Down"),
    Key([mod, "shift"], "Left", lazy.layout.swap_left(), desc="Monadtall move window Left"),
    Key([mod, "shift"], "Right", lazy.layout.swap_right(), desc="Monadtall move window Right"),

    # Toggle Floating Layout
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
]