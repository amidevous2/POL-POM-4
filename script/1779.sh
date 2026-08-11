#!/bin/bash
# Date : (2013-06-26)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : xUbuntu 16.04
# Licence : GPLv3
# Depend : msxml3, d3dx9
#
# CHANGELOG
# [?] (2013-06-26)
#   Initial script.
# [?] (2017-07-28)
#   ? 
# [Dadu042] (2020-01-22 21:30)
#   Wine 2.13-staging -> 3.0.3.

 
# This script was tested using the DVD version of `Civilization IV: Complete'
# version 1.74, bought in Sweden in 2011.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Civilization IV: Complete Edition"
TITLECIV="Civilization IV"
TITLEBTS="Civilization IV - Beyond The Sword"
TITLEW="Civilization IV - Warlords"
TITLECOL="Civilization IV - Colonization"
AUTHOR=""
PREFIX="Civilization4"
WORKINGWINEVERSION="3.0.3"
STEAM_ID_CIV="3900"
STEAM_ID_W="3990"
STEAM_ID_BTS="8800"
STEAM_ID_COL="16810"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1779
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Firaxis Games" "http://www.firaxis.com/" "$AUTHOR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
 
POL_SetupWindow_InstallMethod "DVD,STEAM"
 
if [ "$INSTALL_METHOD" == "DVD" ]; then
    # Let the user select a DVD
    POL_SetupWindow_cdrom
 
    # Check if this DVD is the Civilization IV DVD
    POL_SetupWindow_check_cdrom "Autorun/Civ4Installer.ico"
fi
 
# Set and install the correct Wine version
POL_Wine_PrefixCreate "$WORKINGWINEVERSION"
 
# Install DirectX9
POL_Call POL_Install_d3dx9
 
if [ "$INSTALL_METHOD" == "DVD" ]; then
    # Run installer
    POL_Wine_WaitBefore "$TITLECIV"
    POL_Wine start /unix "$CDROM/setup.exe"
    POL_Wine_WaitExit "$TITLECIV"
 
    # Patch Civilization IV: Beyond the sword to 3.19
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://files.playonlinux.com/Civ4BeyondTheSwordPatch3.19.exe" "c45f6e028f51db2386120a5861eabe7c"
    POL_Wine_WaitBefore "$TITLECIV"
    POL_Wine Civ4BeyondTheSwordPatch3.19.exe
    POL_Wine_WaitExit "$TITLECIV"
else
    POL_Call POL_Install_steam
 
    # Start steam, update it, and install the games
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID_CIV
    POL_SetupWindow_message "$(eval_gettext 'Steam is about to perform an update.\nAfter Steam finishes updating and shows you to the login interface, login and then let $TITLE install.\n\nWhen the installation is finished, press next (Do not close Steam)')" "$TITLECIV"
 
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID_W
    POL_SetupWindow_message "$(eval_gettext 'Steam is installing $TITLEW, press next when the installation is finished')" "$TITLECIV"
 
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID_BTS
    POL_SetupWindow_message "$(eval_gettext 'Steam is installing $TITLEBTS, press next when the installation is finished')" "$TITLECIV"
 
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID_COL
    POL_SetupWindow_message "$(eval_gettext 'Steam is installing $TITLECOL, please quit Steam properly when the installation is finished (make sure Steam is not still in the traybar) and then press next so that the installation script can continue.')" "$TITLECIV"
    POL_Wine_WaitExit "$TITLECIV"
fi
 
# Install msxml3.msi
# Override for msxml3 is needed before the install
# The msvcr71 one is just there so that mods will work later on
 
POL_Wine_OverrideDLL "native" "msxml3"
POL_Wine_OverrideDLL "builtin" "msvcr71"
POL_Call POL_Install_msxml3
 
#Create shortcuts
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_Shortcut "Steam.exe" "$TITLECIV" "$TITLECIV.png" "-applaunch $STEAM_ID_CIV" "Game;StrategyGame;"
    POL_Shortcut "Steam.exe" "$TITLEBTS" "$TITLEBTS.png" "-applaunch $STEAM_ID_BTS" "Game;StrategyGame;"
    POL_Shortcut "Steam.exe" "$TITLEW" "$TITLEW.png" "-applaunch $STEAM_ID_W" "Game;StrategyGame;"
    POL_Shortcut "Steam.exe" "$TITLECOL" "$TITLECOL.png" "-applaunch $STEAM_ID_COL" "Game;StrategyGame;"
    POL_Shortcut "Steam.exe" "Steam - Civ IV" "" "" "Game;"
else
    POL_Shortcut "Civilization4.exe" "$TITLECIV" "$TITLECIV.png" "" "Game;StrategyGame;"
    POL_Shortcut "Civ4BeyondSword.exe" "$TITLEBTS" "$TITLEBTS.png" "" "Game;StrategyGame;"
    POL_Shortcut "Civ4Warlords.exe" "$TITLEW" "$TITLEW.png" "" "Game;StrategyGame;"
fi
 
#Done!
POL_SetupWindow_message "$(eval_gettext 'Installation finished\n')" "$TITLECIV"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYEU2YQAKCRDlMfrJqhPK
R886AJ4hqHPOoO6YYE0QFcADd+312dg+DwCdFRN77zvU2IukPtkf5Gvef9EhwaU=
=n4hH
-----END PGP SIGNATURE-----
