from libqtile import widget
from .theme import colors

def base(fg='text', bg='dark'): 
    return { 'foreground': colors[fg], 'background': colors[bg] }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=3)


def powerline(fg="light", bg="dark"):
    return widget.TextBox( **base(fg, bg), text="", fontsize=37, padding=0)


def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='JetBrainsMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.Prompt(**base(fg='focus'), fontsize=14, padding=5),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),
    powerline('color4', 'dark'),
    widget.Battery(
        **base(bg='color4'),
        charge_char='󱐋', empty_char=' ',
        full_char=' ', discharge_char=' ',
        uknown_char="", format="{char} {percent:2.0%} {watt:.2f} W"
    ),

    # INTERNET STATUS
    powerline('color3', 'color4'),
    icon(bg="color3", text=' '),  # Icon: nf-fa-feed
    widget.Net(**base(bg='color3'), prefix='M'),

    # CURRENT LAYOUT
    powerline('color2', 'color3'),
    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.55),
    widget.CurrentLayout(**base(bg='color2'), padding=5),

    # CALENDAR
    powerline('color1', 'color2'),
    icon(bg="color1", fontsize=17, text='󰃰 '),
    widget.Clock(**base(bg='color1'), format='%Y/%m/%d - %H:%M '),

    # OTHER STUFF
    powerline('dark', 'color1'),
    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline('color1', 'dark'),
    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),
    widget.CurrentLayout(**base(bg='color1'), padding=5),
    powerline('color2', 'color1'),

    widget.Clock(**base(bg='color2'), format='%Y/%m/%d - %H:%M '),
    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'JetBrainsMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 2,
}

extension_defaults = widget_defaults.copy()
