#!/bin/sh
# format="%l:+%C+%t"
format="%l:+%t"
data=$(curl -s "wttr.in/Coban,Guatemala?format=${format}")

echo -e "$data"
