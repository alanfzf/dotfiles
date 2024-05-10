dracula = {
    "dark":     [ "#212121", "#212121" ],
    "grey":     [ "#353c4a", "#353c4a" ],
    "light":    [ "#f1ffff", "#f1ffff" ],
    "text":     [ "#0f101a", "#0f101a" ],
    "focus":    [ "#a151d3", "#a151d3" ],
    "active":   [ "#f1ffff", "#f1ffff" ],
    "inactive": [ "#4c566a", "#4c566a" ],
    "urgent":   [ "#F07178", "#F07178" ],
    "color1":   [ "#a151d3", "#a151d3" ],
    "color2":   [ "#F07178", "#F07178" ],
    "color3":   [ "#fb9f7f", "#fb9f7f" ],
    "color4":   [ "#ffd47e", "#ffd47e" ]
}


catpuccin = {
    "dark":     [ "#1e1e2e", "#1e1e2e" ],
    "grey":     [ "#313244", "#313244" ],
    "light":    [ "#cdd6f4", "#cdd6f4" ],
    "text":     [ "#313244", "#313244" ],
    "focus":    [ "#cba6f7", "#cba6f7" ],
    "inactive": [ "#6c7086", "#6c7086" ],
    "active":   [ "#cdd6f4", "#cdd6f4" ],
    "urgent":   [ "#eba0ac", "#eba0ac" ],

    "color1":   [ "#a6e3a1", "#a6e3a1" ],
    "color2":   [ "#74c7ec", "#74c7ec" ],
    "color4":   [ "#fab387", "#fab387" ],
    "color3":   [ "#f38ba8", "#f38ba8" ],
}




def load_theme():
    theme = dracula
    return theme

if __name__ == "settings.theme":
    colors = load_theme()
