#!/bin/bash
# Date : (2011-11-28 22-00)
# Last revision : (2013-12-08 01-15)
# Wine version used : 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Freeware
# Depend : 7z

# Tested with install archive:
# OUTCASTP_V3.7z 89313352 "6b544b9c1c88d511744a268467bcc41f"
# OUTCAST_V3_PARCHE-HD_Y_FARO_GOG_ByZenger.7z 89121337 "c3cf9ad528acedb9da9b7af787295f7b"

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Must match outcast-gog script values
TITLE_REQUIRED="Outcast (GoG release)"
PREFIX="Outcast_gog"
SHORTCUT_NAME="Outcast"

TITLE="GOG.com - Outcast: High-resolution patch"
URL="http://www.gog.com/forum/outcast/experimental_outcast_hi_res_patch_up_to_1280x768_cyana_lighthouse_problem_fixed/"
INSTALLBIN="OUTCAST_V3_PARCHE-HD_Y_FARO_GOG_ByZenger.7z"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1014
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Zenger" "GOG.com forums" "Pierre Etchemaite" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_LoadVar_PROGRAMFILES

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    POL_SetupWindow_question "$(eval_gettext 'Do you want to read original thread in GOG.com forums?')" "$TITLE"
    [ "$APP_ANSWER" = "TRUE" ] && POL_Browser "$URL"

    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://files.playonlinux.com/$INSTALLBIN" "c3cf9ad528acedb9da9b7af787295f7b"
    ARCHIVE="$POL_USER_ROOT/tmp/$INSTALLBIN"
fi

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

GOGROOT="$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com"
[ -d "$GOGROOT" ] || GOGROOT="$WINEPREFIX/drive_c/GOG Games"

cd "$GOGROOT/Outcast/" || POL_Debug_Fatal "$(eval_gettext 'Error while uncompressing the archive')"
POL_System_ExtractSingleFile "$ARCHIVE" "APPLYMEGAPATCH.exe" "APPLYMEGAPATCH.exe"
POL_System_ExtractSingleFile "$ARCHIVE" "zdata.zpl" "zdata.zpl"
POL_System_ExtractSingleFile "$ARCHIVE" "zdata.zpd" "zdata.zpd"
POL_System_ExtractSingleFile "$ARCHIVE" "zendat.dat" "zendat.dat"
POL_System_ExtractSingleFile "$ARCHIVE" "README_Z.TXT" "README_Z.TXT"

POL_SetupWindow_message "$(eval_gettext 'The patch can now be activated and configured from\nPlayOnLinux s setup wizard for Outcast.\nAnd dont forget to leave a message to Zenger on GoG forums!')" "$TITLE"

POL_SetupWindow_Close

cat <<_EOF_ > $POL_USER_ROOT/configurations/configurators/"$SHORTCUT_NAME".zenger-hires

cd "$GOGROOT/Outcast/" || return
[ -e APPLYMEGAPATCH.exe ] || return

POL_SetupWindow_question "$(eval_gettext 'Run \$TITLE?')" "\$TITLE"
if [ "\$APP_ANSWER" = "TRUE" ]; then

    POL_SetupWindow_wait "\$TITLE" "\$TITLE"

    POL_Wine APPLYMEGAPATCH.exe

    SCREEN_WIDTH=\$(grep '^ScreenWidth=' OUTCAST.ini |cut -d= -f2)
    SCREEN_HEIGHT=\$(grep '^ScreenHeight=' OUTCAST.ini |cut -d= -f2)
    Set_Desktop "On" "\$SCREEN_WIDTH" "\$SCREEN_HEIGHT"

    POL_SetupWindow_message "$(eval_gettext 'Check that the resolution has been changed\n(eventually set to \"HI-RES\") in the loader.')" "\$TITLE"

fi
_EOF_

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKj4kMACgkQ5TH6yaoTykex/gCgsV7AIaMkChgknV1j73F1Vl8m
GbYAn04A5aPdqUkH9pXAcgWsXK8pdSFG
=osRP
-----END PGP SIGNATURE-----
