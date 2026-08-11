#!/bin/bash
# Date : (2010-21-11 21-00)
# Last revision : (2019-10-17 13-46)
# Wine version used : 1.3.6, 1.3.11, 1.3.15, 1.3.23, 1.3.26, 1.3.27, 1.4, 3.0.3
# Distribution used to test : Ubuntu 18.04 amd64
# Author : GNU_Raziel, Dadu042
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [SuperPlumus] (2013-07-23 21-27)
#   Update gettext messages
#   Fix script syntax error
# [Dadu042] (2019-10-17) (I used a DDV edition)
#   Installation of 'vcrun2008 x86 sp1' is launched but does never appear nor end. Log: 'err:systray:initialize_systray Could not create tray window. Application tried to create a window, but no driver could be loaded.' Fix: Wine 3.0.3
#   Add POL_RequiredVersion "4.2.12"

# KNOWN ISSUES  
# - Wine 2.22 + Dotnet40 instead of Dotnet30 : UE3 engine does end, but POL installer does never end. Game launching fail. Fix: Wine 3.0.3
# - Upgrading Wine 1.4 (2013) -> 2.22 (2017)
#     dotnet30 -> dotnet40 (because dotnet30 requires a Root command on Ubuntu 18.04). Dotnet40 is not recognized by the game.
#     dotnet30 -> mono210 (because dotnet30 requires a Root command on Ubuntu 18.04). OK with Wine 3.0.3 (not 2.22).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Alien Breed : Impact"
PREFIX="AlienBreed"
EDITOR="Team17"
GAME_URL="http://www.team17.com/"
AUTHOR="GNU_Raziel, Dadu042"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/AB1/top.jpg" "http://files.playonlinux.com/resources/setups/AB1/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_Call POL_Install_steam
    STEAM_ID="22610"
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9

POL_Call POL_Install_mono210
# POL_Call POL_Install_dotnet30

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
# Begin game installation
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    # Mandatory pre-install fix for steam
    POL_Call POL_Install_steam_flags "$STEAM_ID"
    # Shortcut done before install for steam version
    POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
    POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
    # Steam install
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
    POL_Wine_WaitExit "$TITLE"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi

#Post-install features
POL_SetupWindow_message "$(eval_gettext 'If the Microsoft .NET Framework 3.0 installation fail (launched from the UE3Redist installer), do  not worry\nbecause the game will still work.\n\nAbout DirectX 9 : no need to install it.')" "$TITLE"
UE3=`find $WINEPREFIX -name "UE3Redist.exe"`
POL_Wine start /unix "$UE3"
POL_Wine_WaitExit "Unreal Engine 3.0 redist"

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
    # Shortcut name in 2019 (DDV edition):
    POL_Shortcut "AlienBreed-Impact.exe" "$TITLE" "$TITLE.png" ""
    # Shortcut name in 2013:
    POL_Shortcut "AlienBreedLauncher.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXahW8QAKCRDlMfrJqhPK
R6mnAJ4/XFZUoyWApfrT0wmACLkz1ibR2gCgi7gfxmlZq0yYG0f7UTAKiz6Mquc=
=ooPE
-----END PGP SIGNATURE-----
