#!/bin/bash
# Date : (2010-04-08 10-00)
# Last revision : (2018-02-08 26:07)
# Wine version used : 1.3.3, 1.3.11, 1.3.17, 1.3.25, 1.3.26, 1.3.27, 2.0.1, 3.0
# Distribution used to test : Debian Testing x64, Ubuntu 17.04 x64, Ubuntu 18.04 x64
# Author : GNU_Raziel, LinuxScripter
# Licence : Retail
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Worms Armageddon"
EDITOR="Team 17"
AUTHOR="LinuxScripter"
GAME_URL="http://wa.team17.com/"
PREFIX="WormsArmageddon"
WORKING_WINE_VERSION="3.0"
 
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
POL_Call POL_Function_SetResolution

POL_SetupWindow_message "If you are installing $TITLE from CD, this script will patch the instalation to the latest version. Keep in mind that when the patcher will ask you to apply fixes for Wine, choose No or else the display might be broken. Let the script choose the right registry tweaks."

POL_SetupWindow_InstallMethod "CD,STEAM"
  
if [ "$INSTALL_METHOD" == "CD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "clokspl.exe"
    POL_Wine start /unix "$CDROM/Setup.exe"
    POL_Wine_WaitExit "$CDROM/Setup.exe"
	cd "$POL_System_TmpDir"
	POL_Download "https://worms2d.info/files/WA_update-3.7.2.1_Installer.exe" "bcae1f1424c7b4c20c7b46d998448146"
	POL_Wine start /unix "WA_update-3.7.2.1_Installer.exe"
	POL_Wine_WaitExit "WA_update-3.7.2.1_Installer.exe"
	POL_Wine regedit.exe "$WINEPREFIX/drive_c/Team17/$TITLE/Tweaks/FrontendUseDesktopWindow_Enable.reg"
	POL_Wine regedit.exe "$WINEPREFIX/drive_c/Team17/$TITLE/Tweaks/LoadWormKitModules_Enabled.reg"
	POL_Download "https://steps.keybase.pub/wa/wk/wkSuperFrontendHD_full.7z" "6acb23b43ea3c938dc27c38557cfd4c8"
	unzip wkSuperFrontendHD_full.7z
	cp -r "$POL_System_TmpDir/graphics" "$WINEPREFIX/drive_c/Team17/$TITLE"
	cp "$POL_System_TmpDir/wkSuperFrontend.ini" "$WINEPREFIX/drive_c/Team17/$TITLE"
	cp "$POL_System_TmpDir/wkSuperFrontend.dll" "$WINEPREFIX/drive_c/Team17/$TITLE"
	
else
    POL_Call POL_Install_steam
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine "steam.exe" steam://install/217200
	POL_Wine_WaitBefore "$TITLE"
fi
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "Steam($TITLE)" "" "steam://rungameid/217200"
else
	POL_Shortcut "WA.exe" "Worms Armageddon" "" ""
fi

POL_System_TmpDelete  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNU0EQAKCRDlMfrJqhPK
RyeYAKCIaTf7Obh71rIkmAUUsoxRSyBghACfY8aL78ps/6H75y2vBPWLJtkT2Rg=
=CdZW
-----END PGP SIGNATURE-----
