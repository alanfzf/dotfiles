from libqtile import layout 
from libqtile.config import Match, Screen

# my own settings
from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts
from settings.widgets import widget_defaults, extension_defaults
from settings.screens import screens
from settings.path import qtile_path


# Drag floating layouts.
dgroups_key_binder = None
jgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
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
auto_minimize = True
focus_on_window_activation = "smart"
reconfigure_screens = True
wl_input_rules = None
wmname = "LG3D"
