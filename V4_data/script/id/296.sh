#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# CHANGELOG
# [Altair2010] (2010)
#   First script.
# [Dadu042] (2019-12-22)
#   Wine 1.2.3 -> system version.
#   Add software category.

TITLE="StarUml 5.0"
PREFIX="StarUml50"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "StarUml 5.0" "" "http://staruml.sourceforge.net" "Altaïr 2010" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate ""
POL_Wine_InstallFonts

POL_Call POL_Install_mfc42
POL_Call POL_Install_msxml3
POL_Call POL_Install_LunaTheme

cd "$WINEPREFIX"

POL_Download "http://files.playonlinux.com/staruml-5.0-with-cm.exe" "28706b9697e22353f911a55ee5d6997c"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "staruml-5.0-with-cm.exe"

POL_Shortcut "StarUML.exe" "StarUml 5.0" "" "" "Development;"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXf9ORwAKCRDlMfrJqhPK
R8AHAKCD3kf8hnhhrwzPDU25CDmN6wCmAACglvr/k8zzjPKeFQ7USrpw74gEe8Y=
=Akof
-----END PGP SIGNATURE-----
