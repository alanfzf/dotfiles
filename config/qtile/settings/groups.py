from libqtile.config import Key, Group, ScratchPad, DropDown
from libqtile.lazy import lazy  # Updated import for lazy

from .keys import mod, keys

# BASE GROUPS
groups = [Group(i) for i in [
    "  ", " 󰈹 ", " 󰉋 ", "  ", "  ",
]]

# SCRATCH PADS
groups.append(
    ScratchPad('scratchpad', [
        DropDown('khal', 'foot khal interactive', opacity=1.0, width=0.5, height=0.5, x=0.25, y=0.25),
    ]),
)

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen(toggle=True)),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name, switch_group=True))
    ])
