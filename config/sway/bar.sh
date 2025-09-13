#!/bin/sh

# swaybar protocol header
echo '{"version":1}'
echo '['
echo '[],'

WEATHER_CACHE="/tmp/swaybar_weather.txt"

# In background:
(
  while :; do
    ~/.config/sway/scripts/weather.sh >/dev/null > "$WEATHER_CACHE"
    sleep 600
  done
) &

while :; do
  clock="$(date '+%Y/%m/%d - %H:%M')"
  cpu="$(grep 'cpu ' /proc/stat | awk '{u=($2+$4)*100/($2+$4+$5); printf "%.0f", u}')"
  mem="$(free | awk '/Mem/ {printf "%.0f", $3/$2*100}')"
  net="$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')"
  weather="$(cat $WEATHER_CACHE)"

  echo "[
    {\"name\":\"arrow1\", \"full_text\":\"\", \"color\":\"#fabd2f\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"weather\", \"full_text\":\" $weather\", \"background\":\"#fabd2f\", \"color\":\"#1d2021\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"arrow2\", \"full_text\":\"\", \"color\":\"#fe8019\", \"background\":\"#fabd2f\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"net\", \"full_text\":\" 󰈀  $net \", \"background\":\"#fe8019\", \"color\":\"#1d2021\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"arrow3\", \"full_text\":\"\", \"color\":\"#fb4934\", \"background\":\"#fe8019\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"mem\", \"full_text\":\"   $mem% \", \"background\":\"#fb4934\", \"color\":\"#1d2021\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"cpu\", \"full_text\":\"   $cpu% \", \"background\":\"#fb4934\", \"color\":\"#1d2021\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"arrow4\", \"full_text\":\"\", \"color\":\"#8ec07c\", \"background\":\"#fb4934\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"clock\", \"full_text\":\" 󰃰  $clock \", \"background\":\"#8ec07c\", \"color\":\"#1d2021\", \"separator\":false, \"separator_block_width\":0},
    {\"name\":\"arrow5\", \"full_text\":\"\", \"color\":\"#282828\", \"background\":\"#8ec07c\", \"separator\":false, \"separator_block_width\": 5},
  ],"
  sleep 5
done
