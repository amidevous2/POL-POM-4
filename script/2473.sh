#!/bin/bash
# Date : (2015-20-03 18-14)
# Revised : (2016-29-12 23:25)
# Wine version used : 1.8.6
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-20-03 18-14)
#   Initial script, for the GOG release.
# [Benjamin Hardy] (2016-29-12 23:25)
#   This game has been updated since the script was written. The .exe has been changed to Application-x32.exe. This revised script uses the latest stable WINE release, and has an updated md5sum. dxfullsetup is still required for the audio to work.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.8.6 -> 2.22.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Banished"
PREFIX="Banished"
WINE_VERSION="2.22"
SHORTCUT_NAME="Banished"
GOGID="banished"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Shining Rock Software" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "c1dcc1a2d1c8279bb8881b83ea811a71"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"

POL_Call POL_GoG_install

#directX is required for audio
POL_Call POL_Install_dxfullsetup


POL_Wine_reboot

POL_Shortcut "Application-x32.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;"

POL_SetupWindow_Close

exit 0 

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwcFAAKCRDlMfrJqhPK
RyAOAKCdGuna6VA4VjfK3ogfq9sEXSbS9QCeLotVQxME41SOeoBbaC2ey0iavqI=
=Lqjk
-----END PGP SIGNATURE-----
