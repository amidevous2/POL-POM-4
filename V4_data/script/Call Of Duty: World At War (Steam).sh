#!/bin/bash
# Date : (2015-12-16 18-47)
# Wine version used : 2.22
# Distribution used to test : Mac OS
# Author : Quentin PÂRIS
# Licence : Retail
#
# CHANGELOG
# [Quentin PÂRIS] (2015-12-16 18-47)
#   First script.
# [Dadu042] (2020-01-02)
#   Wine 1.8-rc4-staging -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Call Of Duty: World At War"
PREFIX="CallOfDuty_WorldAtWar"
WORKING_WINE_VERSION="2.22"
STEAM_ID="10090"
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Activision" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

POL_Install_xaudio

POL_SetupWindow_InstallMethod "STEAM"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
fi

POL_Wine_VMS


if [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
fi

cd "$WINEPREFIX/drive_c" 
cat << EOF > audio.reg 
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Classes\CLSID\{fac23f48-31f5-45a8-b49b-5225d61401aa}]
@="\"XAudio2\"
\n"

[HKEY_LOCAL_MACHINE\Software\Classes\CLSID\{fac23f48-31f5-45a8-b49b-5225d61401aa}\InProcServer32]
@="C:\\\\WINDOWS\\\\system32\\\\XAudio2_0.dll"
"ThreadingModel"="Both"

[HKEY_LOCAL_MACHINE\Software\Classes\CLSID\{6f6ea3a9-2cf5-41cf-91c1-2170b1540063}]
@="AudioReverb"

[HKEY_LOCAL_MACHINE\Software\Classes\CLSID\{6f6ea3a9-2cf5-41cf-91c1-2170b1540063}\InProcServer32]
@="C:\\\\WINDOWS\\\\system32\\\\XAudio2_0.dll"
"ThreadingModel"="Both"
EOF 

POL_Wine regedit audio.reg

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5rpQAKCRDlMfrJqhPK
R4X4AJ4on5PMZNoeIQbGzTZXWZdAxz/wjgCePjEu+jQqDXWEvFOD7EDh3Ogga10=
=mr0m
-----END PGP SIGNATURE-----
