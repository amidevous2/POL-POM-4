#!/bin/bash
# 
# App: Railroad Tycoon II Platinum Edition
# Category: Games
# Wine rating: Platinum
# Date : (2014-07-07 15-06)
# Last revision : (2014-07-07 15-06)
# Wine version used : 1.7.8-d3d_doublebuffer
# Distribution used to test : Linux Mint 17 "Qiana" x64
# Author : OdzioM
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Railroad Tycoon II"
PREFIX="RT2"
WORKING_WINE_VERSION="1.7.8-d3d_doublebuffer"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "PopTop Software" "" "OdzioM" "$PREFIX"
POL_SetupWindow_message "$(eval_gettext 'This installer was created for Railroad Tycoon II Platinum Version\nIt should work with other editions of this game:\nRailroad Tycoon II (without addons)\nRailroad Tycoon II Gold Edition (with The Second Century addon)\n\nIf you have one of this two versions of this game, please give some information or bugs at official PlayOnLinux page - http://playonlinux.com/\n\nThank you!')" "$TITLE"

POL_System_TmpCreate "rt2tmp"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose installation mode:
POL_SetupWindow_menu_num "$(eval_gettext 'Select a version of installation disc:')" "$TITLE" "$(eval_gettext 'Retail CD (Platinum, Gold [test], first release [test])')~$(eval_gettext 'Railroad Tycoon Anthology disc (Polish Version)')~$(eval_gettext 'Other destination or other CD/DVD - first release, Gold, Platinum')" "~"

if [ "$APP_ANSWER" == "0" ]; then
	# Version from retail CD - Platinum, Gold [test], first release [test]
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	SETUP_EXE="$CDROM/setup.exe"
elif [ "$APP_ANSWER" == "1" ]; then
	# Railroad Tycoon Anthology disc (Polish Version) - Platinum only
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "_setup/setup.exe"
        SETUP_EXE="$CDROM/_setup/setup.exe"
elif [ "$APP_ANSWER" == "2" ]; then
	# Other destination or other CD/DVD - first release, Gold, Platinum
	cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
fi

POL_Wine "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_menu_num "$(eval_gettext 'What is your version of Railroad Tycoon II?')" "$TITLE" "$(eval_gettext 'First Release (without addons)')~$(eval_gettext 'Gold Edition')~$(eval_gettext 'Platinum Edition')" "~"

if [ "$APP_ANSWER" == "0" ]; then
	POL_Shortcut "RT2.EXE" "$TITLE"
elif [ "$APP_ANSWER" == "1" ]; then
	POL_Shortcut "RT2_GOLD.EXE" "$TITLE Gold"
elif [ "$APP_ANSWER" == "2" ]; then
	POL_Shortcut "RT2_PLAT.EXE" "$TITLE Platinum"
fi

# Complete message
POL_SetupWindow_message "$(eval_gettext 'Installation complete!\nTo run $TITLE please select $TITLE icon from your desktop.\n\nThank you for using this installation script! :)')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO6wkYACgkQ5TH6yaoTykdIFgCfYZSopj3G3uz3zkNEksWI/uc+
9moAoKr6vG6tjGmRh85p99vocoveQYDk
=jSLc
-----END PGP SIGNATURE-----
