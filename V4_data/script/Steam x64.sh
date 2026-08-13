#!/bin/bash

# Date : (2010-02-10 16:30)
# Last revision : (2012-07-21 21:00)
# Wine version used : 1.3.9, 1.3.11, 1.3.15, 1.3.18, 1.3.19, 1.3.23, 1.3.24, 1.2.3, 1.3.28, 1.3.37, 1.4.1
# Distribution used to test : Debian Testing
# Original Author: Tinou
# Licence : JacopKane
# Only For : http://www.playonlinux.com
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Steam"
WINEVERSION="3.17"
GAME_VMS="256"

#starting the script
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Valve" "http://www.valvesoftware.com/" "Tinou" "$PREFIX"

# Si le prefix existe, on propose d'en faire un autre
if [ -e "$POL_USER_ROOT/wineprefix/Steam" ]; then
    POL_SetupWindow_textbox "$(eval_gettext 'Please choose a virtual drive name')" "$TITLE"
    PREFIX="$APP_ANSWER"
else
    PREFIX="Steam"
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x64" # forcing x64
POL_Wine_PrefixCreate "$WINEVERSION"

# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Function_FontsSmoothRGB
POL_Wine_OverrideDLL "" "dwrite"

#downloading latest Steam
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
#POL_Download "http://cdn.steampowered.com/download/$STEAM_EXEC" ""

#Installing Steam
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
POL_Download "http://media.steampowered.com/client/installer/SteamSetup.exe" 

POL_Wine_WaitBefore "$TITLE"
POL_Wine "SteamSetup.exe"

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"

## Fix for Steam
# Note : semble ne plus être nécéssaire désormais?
POL_Wine_OverrideDLL "" "gameoverlayrenderer"
## End Fix

# Making shortcut
POL_Shortcut "Steam.exe" "$TITLE"

#POL_SetupWindow_message "$(eval_gettext 'If you encounter problems with some games, try to disable Steam Overlay')" "$TITLE"


POL_SetupWindow_message "$(eval_gettext 'If you want to install $TITLE in another virtual drive\nRun this installer again')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwWgecACgkQ5TH6yaoTykdBdACgiYG/rTJXF0q8ykUMOg3dAmDF
nyUAnAjnb3faiwwskqT+NYJn1L3+KLCh
=1335
-----END PGP SIGNATURE-----
