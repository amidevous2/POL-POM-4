#!/bin/bash
# Date : (2012-01-09 22-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-01-09 22-00)
#   Initial script.
# [Pierre Etchemaite] (2013-10-30 19-57)
#   ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.4.1 -> 2.22
 
# Tested with install archives:
# setup_arma_cold_war_assault.exe 444364681 "299f5cb319d023b502937a10fc21fc83"

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="arma_cold_war_assault"
PREFIX="ColdWarAssault_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Arma: Cold War Assault"
SHORTCUT_NAME="Arma: Cold War Assault"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1040
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bohemia Interactive Studio" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0c4aceb672ef1a11b85853c2752e159b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "ColdWarAssault.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Arma Cold War Assault/manual.pdf"
# C:\GOG Games\Arma Cold War Assault\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Arma Cold War Assault/" || exit 1

POL_Wine ColdWarAssaultPreferences.exe

exit 0
_EOF_

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYf4AAKCRDlMfrJqhPK
RxMOAJ0dwLcpG1M9tym56DQ/NtZxo5V8CQCeMZUNcnlp1ovqizutEQghibBf6tM=
=f2R+
-----END PGP SIGNATURE-----
