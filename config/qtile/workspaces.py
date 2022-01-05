# -*- coding: utf-8 -*-

# qtile imports
from libqtile.config import Group, Match, Key
from libqtile.lazy import lazy

# Custom Import
from keybindings import keys, mod

# Command to find out wm_class of window: xprop | grep WM_CLASS
workspaces = [
    {
        "name": "Dev",
        "key": "1",
        "label": "",
        "layout": "bsp",
        "matches": [
            Match(wm_class="jetbrains-pycharm"),
            Match(wm_class="Zeal"),
            Match(wm_class="code-oss"),
            Match(wm_class="Atom"),
            Match(wm_class="Sublime_text"),
            Match(wm_class="subl"),
            Match(wm_class="Sublime_merge"),
            Match(wm_class="neovide"),
            Match(wm_class="emacs"),
        ],
        "spawn": [],
    },
    {
        "name": "Web",
        "key": "2",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="Brave-browser"),
            Match(wm_class="Google-chrome"),
            Match(wm_class="chromium"),
            Match(wm_class="LibreWolf"),
            Match(wm_class="firefox"),
        ],
        "spawn": ["brave"],
    },
    {
        "name": "Term",
        "key": "3",
        "label": "",
        "layout": "bsp",
        "matches": [],
        "spawn": [],
    },
    {
        "name": "Book",
        "key": "4",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="Zathura")
        ],
        "spawn": [],
    },
    {
        "name": "Chat",
        "key": "5",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="TelegramDesktop"),
            Match(wm_class="discord"),
        ],
        "spawn": [],
    },
    {
        "name": "Dev2",
        "key": "6",
        "label": "",
        "layout": "monadtall",
        "matches": [],
        "spawn": [],
    },
    {
        "name": "Video",
        "key": "7",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="mpv"),
        ],
        "spawn": [],
    },
    {
        "name": "Music",
        "key": "8",
        "label": "",
        "layout": "monadtall",
        "matches": [
            Match(wm_class="spotify"),
            Match(title="ncmpcpp"),
            Match(title="cmus*"),
        ],
        "spawn": [],
    },
    {
        "name": "GFX",
        "key": "9",
        "label": "",
        "layout": "floating",
        "matches": [
            Match(wm_class="Gimp"),
            Match(wm_class="gimp-2.10"),
            Match(wm_class="GravitDesigner"),
            Match(wm_class="Inkscape"),
        ],
        "spawn": [],
    },
]

groups = []
for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(
        Group(
            workspace["name"],
            matches=matches,
            layout=workspace["layout"],
            spawn=workspace["spawn"],
            label=workspace["label"],
        )
    )
    keys.append(
        Key(
            [mod],
            workspace["key"],
            lazy.group[workspace["name"]].toscreen(),
            desc="Focus certain workspace",
        )
    )
    keys.append(
        Key(
            [mod, "shift"],
            workspace["key"],
            lazy.window.togroup(workspace["name"]),
            desc="Move focused window to another workspace",
        )
    )
