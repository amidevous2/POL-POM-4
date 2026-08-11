#!/bin/bash
#
# Date: (2015-05-27 09:05)
# Wine version used: see changelog.
# Distributions used to test: Linux Mint 17.1 (x64) & Debian GNU/Linux 8.0 (x64)
# Author: MTres19
#
# CHANGELOG
# [MTres19] (2015-05-27 09:05)
#   Initial script.
# [Dadu042] (2020-01-22 21:30)
#   Wine 1.7.43-staging ->  2.22
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="QuickTime"
TITLE="QuickTime Player"
WINEVERSION="2.22"

POL_System_TmpCreate "QuickTime"
cd "$POL_System_TmpDir"

POL_GetSetupImages "https://959ad3af07bee0a51d8a94f55631e2a28a6bbbdb.googledrive.com/host/0B_iE50uqUIIbM3A1VFQ5SlhzV1E" "https://1ad729e00e6db2277920eaba5998a84ebe38c026.googledrive.com/host/0B_iE50uqUIIbOVVYUndDN3k4T2s"

POL_SetupWindow_Init
POL_Debug_Init
POL_System_SetArch "x86"

POL_SetupWindow_presentation "QuickTime Player" "Apple, Inc." "apple.com" "MTres19" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_LunaTheme
POL_Call POL_Install_ie8

Set_OS "winxp" "sp2"

POL_Download "https://secure-appldnld.apple.com/QuickTime/031-08466.20141022.Xwlnm/QuickTimeInstaller.exe"
POL_Wine "QuickTimeInstaller.exe"

POL_Shortcut "QuickTimePlayer.exe" "QuickTime Player" "" "" "Player;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXi9HPgAKCRDlMfrJqhPK
Rz9xAKCV9i2O0D+ZaU/oSos+21xSjbSttwCfbrOrXhPc7SfrpQhzYm7jHmY2PMQ=
=Fzo6
-----END PGP SIGNATURE-----
