#!/usr/bin/env playonlinux-bash
# Date : (2015-12-06 01-12)
# Last revision : 
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Gabriel Huber huberg18@gmail.com / MTres19
#
# CHANGELOG
# [Gabriel Huber or MTres19] (2015-12-06 01-12)
#   Initial script.
# [Yepoleb] (2015-12-06 19-18)
#   ?
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.8-rc1 (outdated) -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="rollercoaster_tycoon_3"
PREFIX="RollerCoasterTycoon3_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - RollerCoaster Tycoon 3"
SHORTCUT_NAME="RollerCoaster Tycoon 3: Platinum!"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2669
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Frontier Developments / Atari" "http://www.gog.com/game/$GOGID" "Gabriel Huber" "$PREFIX"
POL_SetupWindow_message "$(eval_gettext 'At the end of the installation process you might get a few runtime errors, ignore them for now.')" "$TITLE"

POL_Call POL_GoG_setup "$GOGID" "0efb0a51c9edba3699e657d929c88d4f"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# FIXME: Fixes sound, but makes game freeze after quiting
# POL_Call POL_Install_DirectShowFiltersFix

POL_Call POL_GoG_install

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "RCT3plus.exe" "$SHORTCUT_NAME" "" "" "Game;Simulation;"
MANUAL_PATH=`find $WINEPREFIX -iname "RCT3_MANUAL_GBR.pdf"`
POL_Shortcut_Document "$SHORTCUT_NAME" "$MANUAL_PATH"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCiuwAKCRDlMfrJqhPK
R+uVAJ9Y6uxgNlG8ui/7BoxlS3AhlyhlIgCgrVXsi279A51r19s1zuJfB5wX2ac=
=ZFqF
-----END PGP SIGNATURE-----
