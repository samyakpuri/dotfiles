# -*- coding: utf-8 -*-

# General Imports
import os
import subprocess
from typing import List  # noqa: F401

# qtile imports
from libqtile.config import KeyChord, Key, Drag, Click
from libqtile.command import lazy
from libqtile import layout, hook
from libqtile.lazy import lazy
from libqtile import qtile

# Custom Imports
from colors import colors
from keybindings import keys, mod
from workspaces import groups
from screens import screens


layout_theme = {
    "border_width": 3,
    "margin": 5,
    "border_focus": "3b4252",
    "border_normal": "3b4252",
    "font": "h Nerd Font",
    "grow_amount": 4,
}

layouts = [
    layout.Bsp(**layout_theme, fair=False),
    layout.RatioTile(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

# Setup bar

widget_defaults = dict(
    font="Hack Nerd Font Mono Medium", 
    fontsize=14,
    padding=3,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = "floating_only"
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "focus"

# Disable floating for mpv
@hook.subscribe.client_new
def disable_floating(window):
    rules = [
        Match(wm_class="mpv")
    ]

    if any(window.match(rule) for rule in rules):
        window.togroup(qtile.current_group.name)
        window.cmd_disable_floating()

@hook.subscribe.screen_change
def restart_on_randr(_):
	qtile.restart()



# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
