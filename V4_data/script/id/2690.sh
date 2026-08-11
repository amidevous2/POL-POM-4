#!/bin/bash
# Date: 2015-12-26
# Wine version used:
# Distribution used to test: Kubuntu 15.10 (amd64)
# Author: MTres19
#
# CHANGELOG
# [MTres19] (2015-12-26)
#   Initial script.
# [Dadu042] (2020-01-28 21:30)
#   Wine 1.8 (outdated) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Mall Tycoon 2"
PREFIX="MallTycoon2"
WINEVERSION="3.0.3"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Global Star Software" "www.globalstarsoftware.com" "MTres19" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_cdrom
MT2SETUP="$CDROM/install.exe"
POL_Wine_InstallCDROM "d"
POL_Wine "$MT2SETUP"

Set_Desktop "On" "1024" "768"
POL_Wine_reboot

POL_Shortcut "$PROGRAMFILES/Global Star Software/Mall Tycoon 2/Mall.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "$PROGRAMFILES/Global Star Software/Mall Tycoon 2/data/help/eng/Help.htm"
POL_Shortcut_QuietDebug "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCdqgAKCRDlMfrJqhPK
R1PjAJ97WCWZsco6TQToWZZ5RRCAoBJtOwCglTbsG9JTnKjOV0jvMIAey/Z+6js=
=a4oK
-----END PGP SIGNATURE-----
