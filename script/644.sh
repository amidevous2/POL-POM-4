#!/bin/bash
# Date : (2010-05-29)
# Last revision : (2010-05-29)
# Wine version used : 1.1.44
# Distribution used to test : Ubuntu 9.10
# Author : Marco Gerards
# Licence : GPLv3
# Depend : none

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Settlers II 10th Anniversary"
AUTHOR="Marco Gerards"
PREFIX="SettlersII_10thAnniversary"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"
WORKINGWINEVERSION="1.1.44"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

wget http://upload.wikimedia.org/wikipedia/en/b/b5/Settlers_2_10th_Anniversary_cover.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.png"
convert "$REPERTOIRE/tmp/leftnotscaled.png" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Blue Byte Software" "http://www.bluebyte.net/" "$AUTHOR" "$PREFIX"
select_prefix "$PREFIXDIR"

# Let the user select a CDROM
POL_SetupWindow_cdrom

# Check if this CDROM is the correct CDROM.  Unfortunately there is
# not much to check for.
POL_SetupWindow_check_cdrom "/LeggiMi.doc"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"

Use_WineVersion "$WORKINGWINEVERSION"

POL_SetupWindow_prefixcreate

# Install the game
POL_SetupWindow_wait_next_signal "Installing game..." "$TITLE"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit

Set_SoundDriver "oss"

PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

# Make a short cut
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_s2dng.0.png"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Ubisoft/Funatics/The Settlers II - 10th Anniversary/bin" "S2DNG.exe" "" "$TITLE"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykdBkACglJz/Pkvoh+hyySX63sNZOAgV
z4QAn3kVk/xqy2zeGXV4i4u2avMfw3jz
=QEnF
-----END PGP SIGNATURE-----
