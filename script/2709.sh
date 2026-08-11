#!/usr/bin/env playonlinux-bash
# Date : (2015-10-07 18-00)
# Last revision : (2015-10-07 19-05)
# Wine version used :
# Distribution used to test : Ubuntu 15.04 (vivid)
# Author : agentcobra
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Music Shake"
PREFIX="MusicShake"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2709
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "" "http://musicshake.com/" "agentcobra" "$PREFIX"
POL_System_TmpCreate "MusicShake"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
	cd "$POL_System_TmpDir"
	POL_Download "http://pump.musicshake.com/NewDownload/MusicShakeSetup.exe" "4b853f5ed00eca1d5644c14466491e31"
	INSTALLER="$POL_System_TmpDir/MusicShakeSetup.exe"
fi

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win7"

POL_Call POL_Install_Flashplayer_ActiveX

POL_SetupWindow_wait "$(eval_gettext 'Please wait')" "$TITLE - $(eval_gettext 'Installation in progress')"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "MusicShake.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlabQXgACgkQ5TH6yaoTykd/igCgsoANnGT/ahuf5o5HGm7bn1AU
Ks4Anj4iNg5Dj5piDu9UFPhXWkeO5E3v
=TVFQ
-----END PGP SIGNATURE-----
