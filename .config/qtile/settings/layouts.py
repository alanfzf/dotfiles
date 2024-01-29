from libqtile import layout
from libqtile.config import Match
from .theme import colors

# Layouts and layout rules
normal_style = {
    'border_focus': colors['focus'][0],
    'border_width': 2,
}

float_style = {
    'border_width': 2,
    'border_focus': colors['color3'][0]
}

layouts = [
    layout.MonadTall(**normal_style),
    layout.MonadWide(**normal_style),
    layout.Matrix(**normal_style, columns=2),
    layout.RatioTile(**normal_style),
    layout.Max(),
]

floating_layout = layout.Floating(
    **float_style,
    float_rules = [
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)
