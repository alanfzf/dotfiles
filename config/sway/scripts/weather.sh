#!/bin/sh

API_KEY="925ab512a04b339933f00836149ce9db"
CITY_ID="3598119"
UNITS="metric" # or 'imperial' for Fahrenheit

# Fetch weather data from OpenWeatherMap
data=$(curl -s "https://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=${UNITS}")

# Parse needed fields using jq
city=$(echo "$data" | jq -r '.name')
temp=$(echo "$data" | jq -r '.main.temp')
icon=$(echo "$data" | jq -r '.weather[0].icon')

# Map icon to your custom symbols
case $icon in
  "01d") symbol="" ;;
  "01n") symbol="" ;;
  "02d") symbol="" ;;
  "02n") symbol="" ;;
  "03d"|"03n") symbol="" ;;
  "04d"|"04n") symbol="" ;;
  "09d") symbol="" ;;
  "09n") symbol="" ;;
  "10d"|"10n") symbol="" ;;
  "11d"|"11n") symbol="" ;;
  "13d"|"13n") symbol="" ;;
  "50d"|"50n") symbol="" ;;
  *) symbol="" ;;
esac

# Output formatted weather
echo "${city}: ${symbol} ${temp}°"
