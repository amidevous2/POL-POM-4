#!/bin/bash
# Date : (2011-01-18 20-11)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : N/A
# Author : SuperPlumus and ademar

# CHANGELOG
# [Aymeric PETIT / MulX] (2011-10-29 19-05)
#   Updated translations
# [Quentin Pâris] (2011-10-30 14-20)
#   Updated translations
#   PlayOnMac flag (just in case)
# [SuperPlumux] (2012-04-08 14-50)
#   Add POL_Call POL_Install_dxdiag and POL_Install_amstream
#   Change Wine version
# [SuperPlumux] (2013-09-30 08-39)
#   Update gettext messages
# [SuperPlumux] (2015-05-04 11-48)
#   Fix broken url for download amovie.exe (Bug #4786)
#   Fix broken url for dciman32.dll
#   Add POL_SetupWindow_SetID
#   Dont create prefix before InstallMethod (Feature #1027)
# [SuperPlumux] (2020-01-16 21-55)
#   Wine 1.4-rc2 -> 2.22


[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="X3 : Terran Conflict"
PREFIX="X3TC"
WORKING_WINE_VERSION="2.22"
STEAM_ID="2820"

POL_SetupWindow_Init
POL_SetupWindow_SetID 785
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Egosoft" "http://www.egosoft.com" "SuperPlumus and ademar" "$PREFIX"

POL_SetupWindow_InstallMethod "CD,LOCAL,STEAM"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_Call POL_Install_directx9
POL_Call POL_Install_dxdiag
POL_Call POL_Install_amstream
POL_Call POL_Install_wmp10
POL_Call POL_Install_ffdshow
POL_Call POL_Install_xvid

Set_OS "win7"

# Dciman32.dll
cd "$POL_System_TmpDir"
#POL_Download "http://www.dllbank.com/zip/d/dciman32.dll.zip" "dbad3d690b069516b063185140004d90"
POL_Download "http://www.dllfreedownload.com/DLL/d/dciman32.dll.zip" "dbad3d690b069516b063185140004d90"
unzip "dciman32.dll.zip"
mv "dciman32.dll" "$WINEPREFIX/drive_c/windows/system32/"
POL_Wine_OverrideDLL "native,builtin" "dciman32"

# ActiveMovie
#POL_Download "http://downloads.pcworld.com/pub/new/internet/java__plug_ins__and_activex/amovie.exe" "8ec54413b05c2c8c43f91ee8c836b0f0"
POL_Download "http://files.playonlinux.com/Amov4ie.exe" "8ec54413b05c2c8c43f91ee8c836b0f0"
POL_Wine_WaitBefore "ActiveMovie"
POL_Wine start /unix "$POL_System_TmpDir/Amov4ie.exe"
POL_Wine_WaitExit "ActiveMovie"


if [ "$INSTALL_METHOD" = "STEAM" ]; then

POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "$STEAM_ID"
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "LOCAL" ]; then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "CD" ]; then

POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"

fi

POL_Wine_SetVideoDriver

POL_System_TmpDelete

if [ "$INSTALL_METHOD" != "STEAM" ]; then
POL_Shortcut "X3TC.exe" "$TITLE" "" "" "Game;"
fi

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDOKQAKCRDlMfrJqhPK
R7pUAKCUQYd7R0l42WY8L46QknvRn9mZmwCgnxXqTSWtcwoV7MM0F8OnA5U9g+0=
=WS3s
-----END PGP SIGNATURE-----
