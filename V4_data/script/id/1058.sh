#!/bin/bash
# Date : (2012-02-18 12-48)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debiann unstable amd64
# Author : Pierre Etchemaite
#    based on script by GNU_Raziel
# Licence : Retail
#
# CHANGELOG
# [SuperPlumus] (2013-08-20 19-41)
#   Update script
# [Dadu042] (2020-01-22 21:30)
#   Wine "1.7.53-steam_crossoverhack -> 3.0.3.
#   GAME_VMS="512" -> 256

#  Playing windowed with forced mouse capture
#
# 1.4-rc4: "flashes" in smoke/dirt textures
# 1.3.37: idem
# 1.3.36: crash at start
# 1.3.35: crash at start
# 1.3.34: flashes in smoke/dirt
# 1.3.30: idem
# 1.3.28: idem
# 1.3.23: idem
# Flashes fixed with StrictDrawOrdering = enabled


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Call of Duty: Modern Warfare 3"
PREFIX="CallOfDutyMW3"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
VID="42690"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infinity Ward / Sledgehammer Games" "http://www.callofduty.com/mw3" "Pierre Etchemaite" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "$VID"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "steam.exe" "steam://install/$VID"
POL_Wine_WaitExit "$TITLE"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

POL_Wine_X11Drv "GrabFullScreen" "Y"

# Fix moire flashes in smoke and dirt
# POL_Wine_Direct3D "StrictDrawOrdering" "enabled"

# Making shortcut
POL_Shortcut "Steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$VID"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjFbFwAKCRDlMfrJqhPK
R0NqAJ4wENY4FpwhPUzZN4VUplMmCG/TNwCgoARO7dgAKLU7NzgrFzoPjGYMXmI=
=5Cje
-----END PGP SIGNATURE-----
