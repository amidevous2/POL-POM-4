#!/bin/bash
 
# Date : (2010-02-10 16:30)
# Last revision : (2012-07-21 21:00)
# Wine version used : 1.3.9, 1.3.11, 1.3.15, 1.3.18, 1.3.19, 1.3.23, 1.3.24, 1.2.3, 1.3.28, 1.3.37, 1.4.1
# Distribution used to test : Debian Testing
# Author : Tinou
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# Ce script est partculier, il permet d'installer Steam sur autant de préfixe qu'on
# souhaite.
#
# Il faut donc être vigilent, et mettre le moins de paquets possible, pour que
# l'utilisateur puisse les réinstaller à sa guise. Il est facile d'installer vcrun2005,
# par contre il est difficile de le désinstaller.
#
# On installe donc seulement gecko qui est indispensable, et on évite le reste
#
##############################################################
 
# CHANGELOG
# [Baduk] (2017-03-02 15-47)
#   Firt script for Northgard.
# [Dadu042] (2020-08-23 19-00)
#   Wine 2.2 (outdated) -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Steam"
WINEVERSION="3.0.3"
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
POL_System_SetArch "x86" # forcing x86 to avoid any possible x64 related bugs
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Function_FontsSmoothRGB
POL_Wine_OverrideDLL "" "dwrite"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-heap-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-locale-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-runtime-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-stdio-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-convert-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "ucrtbase"
POL_Wine_OverrideDLL "native,builtin" "vcruntime140"
POL_Wine_OverrideDLL "" "d3d11"
 
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

# Mandatory pre-install fix for steam
STEAM_ID="466560"; SHORTCUT_NAME="$Northgard";
 

# Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX0KtjQAKCRDlMfrJqhPK
R/V2AJ4m/c0X1hIsckxqy1LS9I92Du6J5ACfcEqYCxlih8VX/ymU5QVgybU1nUg=
=3Ker
-----END PGP SIGNATURE-----
