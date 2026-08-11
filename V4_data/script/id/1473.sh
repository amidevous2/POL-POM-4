#!/bin/bash
# Date : (2011-12-25 01-41)
# Last revision : 
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-25 01-41)
#   Initial script.
# [Pierre Etchemaite] (2013-11-23 01-11)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)


# Crashes with 1.5.0 (tab key)
#   workaround: WINEDEBUG=warn+heap
# Still crashes with 1.6.1, 1.7.6, 1.7.1-CSMT
# Still crashes with 1.5.17, maybe slightly harder to trigger?

# Lots of crashes with 1.3.35 - pattern in flashlight (intentional?
#   not exactly the one observed in native demo though), and
#   flashlight goes thru obstacles (probably not intentional)
# Crashes with 1.3.34-vertex-blending
# Still some crashes with 1.3.34
# Still some crashes with 1.3.33
# Still some crashes with 1.3.32 (mods, special keys?)
# Still some crashes with 1.3.31
# Still some crashes with 1.3.30 (tab key?)
# Still some crashes with 1.3.29 (tab key)
# No sound out of 1.3.28, and still some crashes
# Still some crashes with 1.3.27-rawinput2 (tab key)
# Crashes woth 1.2.3 (tab key)
# Crashes with 0.9.54 (tab key)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="shadowgrounds"
PREFIX="ShadowGrounds_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Shadowgrounds"
SHORTCUT_NAME="Shadowgrounds"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1473
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Frozenbyte / Meridian4" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "4ccc3fa68b79eb23a4471258d2578668"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


Set_OS winxp

POL_SetupWindow_VMS "128"

POL_Call POL_Install_wmp10
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Shadowgrounds Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Shadowgrounds/Manual.pdf"
# C:\GOG Games\Shadowgrounds\Readme.txt
# C:\GOG Games\Shadowgrounds\weapon_chart.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCWXQAKCRDlMfrJqhPK
R6x1AJ4j83WJEuh+wKmx5XZuPPZr7ShXUwCeKJleWpOb44kNbZJH4r7k0xI6xCU=
=kpiB
-----END PGP SIGNATURE-----
