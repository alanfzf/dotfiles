from libqtile.config import Screen
from libqtile import bar
from .widgets import primary_widgets, secondary_widgets

qtile_wall = "/usr/share/wallpapers/Anime/idk.png"

def status_bar(widgets):
    return bar.Bar(widgets, size=30)

screens = [
        Screen(
            wallpaper=qtile_wall,
            wallpaper_mode="fill",
            top=status_bar(primary_widgets)
            ),
        Screen(
            wallpaper=qtile_wall,
            wallpaper_mode="fill",
            top=status_bar(secondary_widgets)
            ),
        ]
