#!/bin/bash 
# Date : (2010-02-10 16:30)
# Last revision : see changelog
# Wine version used : Please refer to https://appdb.winehq.org/objectManager.php?sClass=application&iId=1163
# Distribution used to test : Xubuntu 18.04 amd64
# Author : Tinou
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# ENGLISH: This script is specific, it allow to install Steam for as many prefix the user wishes.
#
# FRENCH: Ce script est particulier, il permet d'installer Steam sur autant
# de préfixes que le souhaite l'utilisateur.
# Il faut donc être vigilent, et mettre le moins de paquets possible, afin que
# l'utilisateur puisse les réinstaller à sa guise.
# Note: Il est facile d'installer vcrun2005, par contre il est difficile de le désinstaller.
# On installe donc seulement Gecko qui est indispensable, et on évite le reste.
#
##############################################################
 
# CHANGELOG
# [SuperPlumus] (2013-06-09 15-47)
#    gettext
# [Quentin Paris] (2018-10-18)
#    wine 2.12-staging -> 3.17
# [Dadu042] (2020-04-30 10-00)
#    Wine 3.17 (outdated) -> 4.21
# [Dadu042] (2020-08-10 10-00)
#    [CHANGED] Wine 4.21 -> 5.0.1
#    [CHANGED] POL_SetupWindow_VMS moved.
#    [CHANGED] Comments


# KNOWN ISSUES :
#  - (2020-08) Wine amd64 4.21, 5.0.1, 5.12: the center of the Steam window is black (top and bottom menus does appear). Tried: Gecko.
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.1: X

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Steam"
WINEVERSION="5.0.2"
GAME_VMS="256"
 
# Starting the script
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Valve" "http://www.valvesoftware.com/" "Tinou" "$PREFIX"
 
# If the prefix already exist, we can create a new one.
if [ -e "$POL_USER_ROOT/wineprefix/Steam" ]; then
    POL_SetupWindow_textbox "$(eval_gettext 'Please choose a virtual drive name')" "$TITLE"
    PREFIX="$APP_ANSWER"
else
    PREFIX="Steam"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Forcing x86 to avoid any possible x64 related bugs
POL_System_SetArch "x86"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Function_FontsSmoothRGB
POL_Wine_OverrideDLL "" "dwrite"
 
# Downloading latest Steam
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
 
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
# POL_Download "http://cdn.steampowered.com/download/$STEAM_EXEC" ""
POL_Download "http://media.steampowered.com/client/installer/SteamSetup.exe"

# Installing Steam
POL_Wine_WaitBefore "$TITLE"
POL_Wine "SteamSetup.exe"
 
 
## Fix for Steam
# Note : seems not necessary nowadays ? (2018)
POL_Wine_OverrideDLL "" "gameoverlayrenderer"
## End Fix
 
# Make shortcut
POL_Shortcut "Steam.exe" "$TITLE" "" "" "Game;"
 
# POL_SetupWindow_message "$(eval_gettext 'If you encounter problems with some games, try to disable Steam Overlay.')" "$TITLE"
 
 
POL_SetupWindow_message "$(eval_gettext 'If you want to install $TITLE in another virtual drive, you can run this installer again.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX6pMIgAKCRDlMfrJqhPK
R0sOAJ0XvGD5Ae3b0xJEnsoQitFnrdMJGACcD5Wc/HoBjHt+nb0sC6HA7RYxQtg=
=Wsja
-----END PGP SIGNATURE-----
