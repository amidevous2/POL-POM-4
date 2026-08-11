#!/bin/bash
# Date : (2009-22-11 10-15)
# Last revision : (2015-10-23)
# Wine version used :1.7.46-staging
# Distribution used to test : Mac OS
# Author : Quentin PÂRIS
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Age Of Empires III"
PREFIX="AgeOfEmpireIII"
WORKING_WINE_VERSION="4.0"
STEAM_ID="105450"
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Ensemble Studios" "www.ageofempires3.com" "NSLW & GNU_Raziel" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

#Installing mandatory components
POL_Call POL_Install_vcrun6
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_msxml4
# Helps with entering CD key https://bugs.winehq.org/show_bug.cgi?id=20456
POL_Call POL_Install_corefonts

POL_SetupWindow_InstallMethod "LOCAL, STEAM"

if [ "$INSTALL_METHOD" == "CD" ]; then
	cd $HOME
	POL_SetupWindow_browse "$(eval_gettext "Please select the setup file")" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE" --allow-kill
	POL_Shortcut "age3.exe" "$TITLE"
fi
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
fi

POL_Wine_VMS

#Fix for this game
POL_Wine regsvr32 l3codecx.ax 
cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > AoE3_Fix.reg
echo "\"quartz\"=\"builtin,native\"" >> AoE3_Fix.reg
echo "\"devenum\"=\"native\"" >> AoE3_Fix.reg
echo "\"msxml4\"=\"native\"" >> AoE3_Fix.reg
POL_Wine regedit AoE3_Fix.reg



if [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
fi
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlxjWcMACgkQ5TH6yaoTykdJAwCfSjBLvJD9SBIbGiMA8yNnRx8x
k68An1V1sF9OCyHrdjgO7w6zwWRpmIpN
=wvVI
-----END PGP SIGNATURE-----
