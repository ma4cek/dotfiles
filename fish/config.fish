if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

# Force Mozilla to use Wayland
set -x MOZ_ENABLE_WAYLAND 1
# Force Steam to use Wayland
set -x SDL_VIDEODRIVER 'wayland'
# set -x QT_STYLE_OVERRIDE 'kvantum'

# recomended enviroment variables for sway based desktop
# openSUSEway installs/imports this to/from:
# /usr/lib/environment.d/50-openSUSE.conf
# /etc/profile.d/openSUSEway.sh
set -x QT_QPA_PLATFORM 'wayland-egl'
set -x CLUTTER_BACKEND 'wayland'
set -x ECORE_EVAS_ENGINE 'wayland-egl'
set -x ELM_ENGINE 'wayland_egl'
set -x _JAVA_AWT_WM_NONREPARENTING 1
set -x NO_AT_BRIDGE 1
set -x WLR_RENDERER 'vulkan'

# QT theme for openSUSEway
# needs qt5ct and adwaita-qt5 packages
# default config is /etc/xdg/qt5ct/qt5ct.conf
set -x QT_QPA_PLATFORMTHEME 'qt5ct'
