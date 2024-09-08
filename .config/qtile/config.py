# MY OWN SETTINGS
from libqtile import hook
import subprocess
from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults
from settings.screens import screens
from settings.path import qtile_path
from libqtile.backend.wayland import InputConfig

wl_input_rules = {
    "*": InputConfig(pointer_accel=False),
    "type:keyboard": InputConfig(kb_options="ctrl:nocaps,compose:ralt"),
}

# Drag floating layouts.
dgroups_key_binder = None
jgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
auto_minimize = True
focus_on_window_activation = "smart"
reconfigure_screens = True
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    processes = [
        ['swaync'],
    ]

    for p in processes:
        subprocess.Popen(p)
