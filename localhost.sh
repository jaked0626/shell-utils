#!/bin/bash

port=${1:-3000}
url="http://localhost:$port"

if which xdg-open > /dev/null; then
  xdg-open $url
elif which gnome-open > /dev/null; then
  gnome-open $url
elif which open > /dev/null; then
  open $url
else
  echo "Could not detect the web browser to use."
  exit 1
fi
