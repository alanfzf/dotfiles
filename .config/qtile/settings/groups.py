from libqtile.config import Key, Group
from libqtile.lazy import lazy  # Updated import for lazy
from .keys import mod, keys

groups = [Group(i) for i in [
    "  ", " 󰖟 ", " 󰉋 ", "  ", "  ", "   ", " 󱞁 ", " 󰙯 ", "  "
]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen(toggle=True)),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name, switch_group=True))
    ])
