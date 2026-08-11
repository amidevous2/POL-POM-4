#!/bin/bash
# Date : (2010-05-24)
# Last revision : (2010-05-24)
# Wine version used : 1.1.44
# Distribution used to test : Ubuntu 9.10
# Author : Marco Gerards
# Licence : GPLv3
# Depend : none

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Jerusalem: The 3 Roads To The Holy Land"
AUTHOR="Marco Gerards"
PREFIX="Jerusalem"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"
WORKINGWINEVERSION="1.1.44"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

wget http://upload.wikimedia.org/wikipedia/en/0/06/Jerusalem-_The_Three_Roads_to_the_Holy_Land.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.png"
convert "$REPERTOIRE/tmp/leftnotscaled.png" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Cryo" "http://www.cryo.fr" "$AUTHOR" "$PREFIX"
select_prefix "$PREFIXDIR"

# Let the user select a CDROM
POL_SetupWindow_cdrom

# Check if this CDROM is the correct CDROM
POL_SetupWindow_check_cdrom "/Jerusalem.msi"

# To make sure the user has the same environment as the game was
# tested with.
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"

Use_WineVersion "$WORKINGWINEVERSION"

POL_SetupWindow_prefixcreate

Set_OS "win98"

PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

# Run the installer
POL_SetupWindow_wait_next_signal "Installing game..." "$TITLE"
wine msiexec /i "$CDROM/Jerusalem.msi" /q INSTALLDIR="C:\\$PROGRAMFILES\\Jerusalem"
POL_SetupWindow_detect_exit

wine reboot

# Make a short cut
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_jerusalem.0.png"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Jerusalem" "Jerusalem.exe" "" "$TITLE"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

# Done!
POL_SetupWindow_message "$TITLE installed."

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykczaQCfbIdkXiYrSuvRqUIkJp4P7+ga
HV0AnRAu9iu2DTVwa8t5QJ4bd63CvyaW
=hQ6B
-----END PGP SIGNATURE-----
