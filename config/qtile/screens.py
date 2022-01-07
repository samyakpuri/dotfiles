#other imports
import os
import subprocess
from glob import glob

#qtile import
from libqtile.config import Screen
from libqtile import bar, widget
from libqtile import qtile
from libqtile.lazy import lazy

from colors import colors
from keybindings import terminal

wallpaper = os.getenv('XDG_DATA_HOME')
wallpaper = os.path.expanduser(wallpaper+'/sp/wall*')
wallpaper = glob(wallpaper)[0]

text_size = 14
icon_size = 14

# Set Automatically the number of screens
def get_num_screens():
    output = [l for l in subprocess.check_output(["xrandr"]).decode("utf-8").splitlines()]
    return [l.split()[0] for l in output if " connected " in l]

def init_widgets_screen(primary = False):
    widgets_list = [
            widget.Sep(
                linewidth = 0,
                foreground = colors[2],
                padding = 10,
                size_percent = 40,
            ),
            widget.TextBox(
                text = " ",
                fontsize = 20,
                padding = 10,
                mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal)},
            ),
            widget.GroupBox(
                font = "Font Awesome 5 Free Solid",
                fontsize = 12,
                padding =  5,
                borderwidth =  4,
                active =  colors[9],
                inactive =  colors[10],
                disable_drag =  True,
                rounded =  True,
                highlight_color =  colors[2],
                block_highlight_text_color =  colors[8],
                highlight_method =  "line",
                this_current_screen_border =  colors[0],
                this_screen_border =  colors[7],
                other_current_screen_border =  colors[0],
                other_screen_border =  colors[0],
                foreground =  colors[1],
                # background =  colors[14],
                urgent_border =  colors[3],
            ),
            widget.Sep(
                linewidth = 0,
                foreground = colors[2],
                padding = 10,
                size_percent = 40,
            ),
            widget.CurrentLayoutIcon(
                custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                foreground = colors[1],
                padding = -2,
                scale = 0.45,
            ),
            widget.Sep(
                linewidth = 0,
                foreground = colors[2],
                padding = 5,
                size_percent = 50,
            ),
            widget.WindowName(
                fontsize = text_size,
                padding = 10,
                foreground = colors[1],
            ),
            widget.Spacer(),
        ]
    
    if primary:
        widgets_list.extend([
            widget.Systray(
                padding = 5,
            ),
            widget.Sep(
            linewidth = 0,
            foreground = colors[1],
            padding = 10,
            size_percent = 50,
            ),
        ])

    widgets_list.extend([
            widget.TextBox(
                text = " ⟳",
                font = "Font Awesome 5 Free Solid",
                fontsize = icon_size,
                padding = 2,
                foreground = colors[8],
            ),
            widget.CheckUpdates(
                foreground = colors[3],
                colour_have_updates = colors[3],
                distro = "Arch_checkupdates",
                display_format = " {updates}",
                padding = 5,
                update_interval = 1800,
                mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -t update -e paru')},
            ),
            widget.Sep(
                linewidth = 0,
                padding = 5,
                size_percent = 50,
            ),  
            widget.TextBox(
                text = " ",
                font = "Font Awesome 5 Free Solid",
                fontsize = icon_size,
                foreground = colors[8],
            ),
            widget.PulseVolume(
                fontsize = text_size,
                limit_max_volume = "True",
                update_interval = 0.1,
                mouse_callbacks = {'Button3': lambda: qtile.cmd_spawn(terminal + ' -t pulsemixer -e pulsemixer')},
                foreground = colors[1],
            ),
            widget.Sep(
                linewidth = 0,
                padding = 5,
                size_percent = 50,
            ),
            widget.TextBox(
                text = " ",
                font = "Font Awesome 5 Free Solid",
                padding = 2,
                fontsize = icon_size,
                foreground = colors[8],
            ),
            widget.Clock(
                format = "%b %d",
                foreground = colors[1],
                fontsize = text_size,
            ),
            widget.Sep(
                linewidth = 0,
                padding = 5,
                size_percent = 50,
            ),
            widget.TextBox(
                text = " ",
                font = "Font Awesome 5 Free Solid",
                fontsize =  text_size,
                padding = 2,
                foreground = colors[8],
            ),
            widget.Clock(
                format = "%H:%M",
                fontsize = text_size,
                foreground = colors[1],
            ),
            widget.Sep(
                linewidth = 0,
                padding = 5,
                size_percent = 50,
            ),
            widget.TextBox(
                text = "🇮🇳 ",
                fontsize =  text_size,
                padding = 2,
                foreground = colors[8],
            ),
            widget.Clock(
                timezone = 'Asia/Kolkata',
                format = "%H:%M",
                fontsize = text_size,
                foreground = colors[1],
            ),
            widget.Sep(
                linewidth = 0,
                foreground = colors[1],
                padding = 20,
                size_percent = 50,
            ),
        ])

    return widgets_list

def create_screen(primary):
    return Screen(
                wallpaper = wallpaper,
                wallpaper_mode = "fill",
                top = bar.Bar( widgets = init_widgets_screen(primary),
                    size = 32,
                    margin = [0, -10, 5, -10],
                ),
                bottom = bar.Gap(5),
                left = bar.Gap(5),
                right = bar.Gap(5),
            )

connected = get_num_screens()

screens = []

if len(connected) > 1:
    screens.append(create_screen(False))
    screens.append(create_screen(True))
else:
    screens.append(create_screen(True))
