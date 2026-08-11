#!/bin/bash
# Date                      : (2013-05-11 09-35)
# Last revision             : see changelog
# Wine version used         : 
# Distribution used to test : Xubuntu 12.04.2 LTS
# Author                    : ntzrmtthihu777
# Testers                   :
#
# CHANGELOG
# [ntzrmtthihu777] (2013-05-10 06-25)
#   Initial script.
# [Dadu042] (2020-01-22 13:30)
#   Wine 1.5.29 -> system

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Warcraft II - Battle.net Edition"
PREFIX="WarcraftII_BNE"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://us.blizzard.com/en-us/" "ntzrmtthihu777" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

# choses cd, installs program
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
POL_Wine "$CDROM/SETUP.EXE"
POL_Wine_WaitExit "$TITLE"

# sets some registry keys needed for full function on some systems
POL_Wine_X11Drv "GrabFullscreen" "Y"
POL_Wine_X11Drv "Decorated" "N"
POL_Wine_X11Drv "Managed" "N"

# creates shortcut
POL_Shortcut "Warcraft II BNE.exe" "Warcraft II" "" "" "Game;StrategyGame;"
POL_Shortcut "Warcraft II Map Editor.exe" "Warcraft II Map Editor" "" "" "Game;StrategyGame;"
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNU7QAKCRDlMfrJqhPK
R4jXAKCFHHEwBP7YT2ohYNjbR7u7E8FLEgCaAjMtNv+KItkDHyghdv7ORYg+N5c=
=/t3i
-----END PGP SIGNATURE-----
