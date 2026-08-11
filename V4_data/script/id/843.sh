#!/usr/bin/env playonlinux-bash
# Date : (2011-09-10 20:19)
# Last revision : (2019-05-11 21-14)
# Wine version used : 4.1 (2011: v1.3.28)
# Distribution used to test : Ubuntu 19.04
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# Changelog 
# 2019-05-11 Dadu042 : repair function xmllite.
# 2011-09-10 GNU_Raziel : script first release.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Next BIG Thing"
PREFIX="tnbt"
WORKING_WINE_VERSION="4.1"
AUTHOR="Dadu042"
EDITOR="Pendulo Studios"
GAME_URL="https://pcgamingwiki.com/wiki/The_Next_Big_Thing"

GAME_VMS="256"


# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/tnbt/top.jpg" "http://files.playonlinux.com/resources/setups/tnbt/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 4.x
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # Forcing x86 prefix to avoid game crash
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,DVD,STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Call POL_Install_steam
fi

POL_Call POL_Install_dxfullsetup

POL_Call POL_Install_xmllite # Fix save issues

POL_SetupWindow_message  "Warning: Please DO NOT install DirectX (this is the way this script was tested).\nAnd do not launch the game at the end of the installation." "$TITLE"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup.exe"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/58580
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/58570
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
  
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section
  
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Shortcut "steam.exe" "$TITLE_DEMO" "$TITLE.png" "steam://rungameid/58580"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/58570"
else
        POL_Shortcut "The Next Big Thing.exe" "$TITLE" "$TITLE.png" ""
        POL_Shortcut "The Next Big Thing.exe" "$TITLE - Config" "$TITLE.png" ""
fi
 
# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
 POL_Call POL_Function_NoCDWarning
 # POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine.')" "$TITLE"
fi
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiGgAAKCRDlMfrJqhPK
R5C5AJ9OuHj49DAe2gn1sHIZ/y9hsfTJBQCaAxKdrj9tLXcK7sCX8SnP+XO1T1k=
=+3j5
-----END PGP SIGNATURE-----
