#!/bin/bash
# Date : (2010-29-09 22-00)
# Last revision : see changelog
# Wine version used : 1.3.9, 1.3.15, 1.2.23, 1.3.27, 1.3.28
# Distribution used to test : Ubuntu 14.10 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2010-29-09 22-00)
#   Initial script.
# [dizlexic] (2015-04-18 16:53)
#   ?
# [Dadu042] (2020-01-29 21:00)
#   Wine 1.7.36 (outdated) -> 3.20
#   Standardize POL_Call POL_Function_NoCDWarning

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dragon Age : Origins"
UPDATER="Dragon Age (DLC Installer)"
PREFIX="daorigins"
WORKING_WINE_VERSION="3.20"
GAME_VMS="256"

#starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/daorigins/top.jpg" "http://files.playonlinux.com/resources/setups/daorigins/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "BioWare" "http://dragonage.bioware.com/" "GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # Forcing x86 to avoid DVD install failure
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies for Steam version
if [ "$INSTALL_METHOD" == "STEAM" ]; then
  POL_Call POL_Install_steam
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "17450"

# Begin game installation 
if [ "$INSTALL_METHOD" == "DVD" ]; then
  # Asking for CDROM and checking if it's correct one
  POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "data/da_icon.ico"
  cd "$WINEPREFIX"/dosdevices
  ln -s "$CDROM" d:
  POL_Wine start /unix "$CDROM/Setup.exe"
  POL_SetupWindow_message "$(eval_gettext 'When game setup will ask for next DVD\nclick on \"Forward\"')"
  POL_Wine eject
  POL_SetupWindow_message "$(eval_gettext 'Please insert media 2 into your disk drive\nif not already done.')"
  POL_SetupWindow_cdrom
  cd "$WINEPREFIX"/dosdevices
  rm ./d:
  ln -s "$CDROM" d:
  POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
  cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
  POL_Wine start /unix "steam.exe" steam://install/17450
  POL_Wine_WaitExit "$TITLE"
else
  # Asking then installing DDV of the game
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
  SETUP_EXE="$APP_ANSWER"
  POL_Wine start /unix "$SETUP_EXE"
  POL_Wine_WaitExit "$TITLE"
fi

# Installing mandatory dependencies - need to be post-install for this game
if [ "$INSTALL_METHOD" != "STEAM" ]; then
  # Already installed if it's Steam version
  POL_Wine_InstallFonts
  POL_Function_FontsSmoothRGB
fi

POL_Call POL_Install_vcrun6
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_mono26
POL_Call POL_Install_d3dx9
POL_Call POL_Install_physx

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
  rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
  chmod -R 777 "$POL_USER_ROOT/tmp/"
  rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
  POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/17450"
else
  POL_Shortcut "daorigins.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi
POL_Shortcut "daupdater.exe" "$UPDATER" "$UPDATER.png" ""

# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
  POL_Call POL_Function_NoCDWarning
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH9NgAKCRDlMfrJqhPK
RzkFAJ9zMkUNyrWpMrybDqeBnsifBn4JIQCfev5DO3MHMoHPIdBpPGaI99HvZx4=
=GI7q
-----END PGP SIGNATURE-----
