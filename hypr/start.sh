nh#!/usr/bin/env bash

# wallpaper daemon
swww init &
swww img ~/Wallpapers/catpuccin_w.png &

# networkmanager applet
nm-applet --indicator &

/nix/store/$(ls -la /nix/store | grep 'gnome-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-ghome-authentication-agent-1 & 


waybar &

dunst

swayidle -w &

