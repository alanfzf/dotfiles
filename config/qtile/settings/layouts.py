from libqtile import layout
from .theme import colors

# Layouts and layout rules
normal_style = {
  'border_focus': colors['focus'][0],
  'border_normal': colors['inactive'][0],
  'border_width': 2,
  'margin': 5,
}

float_style = {
  'border_width': 2,
  'border_focus': colors['color3'][0],
  'border_normal': colors['inactive'][0],
  'margin': 5,
}

layouts = [
  layout.MonadTall(**normal_style),
  layout.MonadWide(**normal_style),
  layout.Matrix(**normal_style, columns=2),
  layout.RatioTile(**normal_style),
]

floating_layout = layout.Floating(
  **float_style,
  float_rules = [
    *layout.Floating.default_float_rules,
  ]
)
