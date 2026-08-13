#!/bin/bash
# Date : (2009-07-07 19-30)
# Last revision : (2013-08-17 19-10)
# Wine version used : N/A
# Distribution used to test : N/A

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="iTunes 10"
PREFIX="iTunes10"


POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/itunes/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 815
POL_Debug_Init
POL_SetupWindow_presentation "$TITRE" "Apple" "http://www.apple.com" "Tinou" "$PREFIX"

POL_SetupWindow_question "$(eval_gettext 'Do you want to install $TITLE to sync a USB device?')" "$TITLE"

if [ "$APP_ANSWER" = "TRUE" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Wine does not support USB yet. You will not able to sync your iDevices with $APPLICATION_TITLE. Sorry')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
setup="$APP_ANSWER"
if [ "$(basename "$setup")" = "iTunes64Setup.exe" ]; then
	POL_Debug_Fatal "$(eval_gettext 'Please select the 32-bit version of iTunes')"
fi

POL_System_SetArch "x86"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

POL_Download "$SITE/divers/QuickTime.qtp" "417f9bf5ec52d3bfa5826b4905658dac"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4.1"

Set_OS winxp

POL_Wine_WaitBefore "$TITLE"

cd "$WINEPREFIX/drive_c/users"
for user in *
do
	cd "$WINEPREFIX/drive_c/users/$user"
	mkdir -p "Local Settings/Application Data/Apple Computer/QuickTime"
	cd "Local Settings/Application Data/Apple Computer/QuickTime"
	mv QuickTime.qtp QuickTime.back
	cp "$POL_System_TmpDir/QuickTime.qtp" ./
done

POL_Call POL_Install_LunaTheme

POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$setup" /silent

POL_Call POL_Install_gdiplus
POL_Shortcut "iTunes.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVGADIACgkQ5TH6yaoTykdItwCgjMG00s1CN+p1MSS8Zy5Gz43o
Z/QAnRPhuaWNQoXrPW8Mutal02tXAISF
=rnA+
-----END PGP SIGNATURE-----
