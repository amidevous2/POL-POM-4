#!/bin/bash
# Date : (2015-03-08)
# Last revision : (2015-03-08)
# Wine version used : 1.7.6
# Distribution used to test : Gentoo
# Author : Seiji

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="magrunner_dark_pulse"
PREFIX="magrunner_gog"
WORKING_WINE_VERSION="1.7.6"

# 256MB vRam required
GAME_VMS="256"

TITLE="GOG.com - Magrunner: Dark Pulse"
SHORTCUT_NAME="Magrunner: Dark Pulse"

LANG_EMULATE_DESKTOP="$(eval_gettext 'Since Magrunner is tending to misbehave, we will emulate a desktop to run in.')"
LANG_EMULATE_DESKTOP_WIDTH="$(eval_gettext 'Width of the emulated desktop.')"
LANG_EMULATE_DESKTOP_HEIGHT="$(eval_gettext 'Height of the emulated desktop.')"

LANG_SETUP_CRASH_WARNING="$(eval_gettext 'The setup will throw some errors at the end. They can be ignored.')"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Frogwares" "http://www.gog.com/game/$GOGID" "Seiji" "$PREFIX"

# installer and one bin-file
POL_Call POL_GoG_setup "$GOGID" "2861ed090e4029325e78c77018d0ace8" "b2ac2b4f6d03a0080b0420b57e1b6265"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# basic configuration
Set_OS winxp
POL_SetupWindow_VMS "$GAME_VMS"

# required for audio-support
POL_Call POL_Install_xact

# game tends to misbehave without the emulated desktop
POL_SetupWindow_message "$LANG_EMULATE_DESKTOP" "$TITLE"
POL_SetupWindow_textbox "$LANG_EMULATE_DESKTOP_WIDTH" "$TITLE" "1024"
DESKTOP_WIDTH="$APP_ANSWER"
POL_SetupWindow_textbox "$LANG_EMULATE_DESKTOP_HEIGHT" "$TITLE" "768"
DESKTOP_HEIGHT="$APP_ANSWER"
Set_Desktop "On" "$DESKTOP_WIDTH" "$DESKTOP_HEIGHT"
# allow cursor-capturing for the emulated desktop
POL_Wine_X11Drv "GrabFullScreen" "Y"

POL_SetupWindow_message "$LANG_SETUP_CRASH_WARNING" "$TITLE"

# installer with nogui is constantly crashing - use the new one instead
POL_Call POL_GoG_install

# fix GPU-Incompatibility error
# replace every occurance of "=0," with "=3,"
sed -i "$GOGROOT/Magrunner - Dark Pulse/YoshiGame/Config/DefaultSystemSettings.ini" -e 's/=0,/=3,/g'

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Magrunner.exe" "$SHORTCUT_NAME"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUeySoACgkQ5TH6yaoTykdO3gCghBtfOQDEqD8Cirl43KF2BJjD
QqcAoKSET+4Gma+fQK+2mJPA9QXQDodc
=JXCz
-----END PGP SIGNATURE-----
