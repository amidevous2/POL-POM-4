#!/usr/bin/env playonlinux-bash
# Date : (2020-07-07 16-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : 
# Author : see changelog
#
# CHANGELOG
# [Danilo] (2020-07-07 16-00)
#   Initial script.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="OptCut Free"
SOFTWARE_URL="https://migg.it/optcutfree"
PREFIX="optcutfree"

EDITOR="MIGG Informatica & Ricerca"
EDITOR_URL="https://migg.it"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

mkdir -p "$WINEPREFIX/drive_c/Migg"
cd "$WINEPREFIX/drive_c/Migg"
POL_Download "https://migg.it/files/demo/OptCutDemo.exe" "ac348fd00322e4337dbd723cd17a27b2" # v4.0.22

POL_Wine_WaitBefore "$TITLE"
POL_Wine OptCutDemo.exe
POL_Wine_WaitExit "$TITLE"
POL_Call POL_Install_LunaTheme

POL_Shortcut "OptCut4.exe" "$TITLE" "" "" "Office;"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwS50AAKCRDlMfrJqhPK
R2M2AKCNdaouFzGtIjOS7mI/yuJu7SFYdgCfYPLEP8KKyOtwzMqK+vwWsRNHQQY=
=Z4DB
-----END PGP SIGNATURE-----
