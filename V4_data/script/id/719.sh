#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
 


TITLE="Teach 2000"
TITRE="$TITLE"
PREFIXE="Teach2000"
file="teach851.exe"
 
POL_SetupWindow_Init 
POL_SetupWindow_presentation "$TITRE" "Teach 2000" "http://www.teach2000.org/" "Tinou" "$PREFIXE"
cd $REPERTOIRE/tmp/
select_prefix "$REPERTOIRE/wineprefix/$PREFIXE"
POL_SetupWindow_prefixcreate
POL_SetupWindow_download "Downloading $TITRE" "$TITRE" "http://www.digischool.nl/teach2000/teach851.exe"
POL_SetupWindow_wait_next_signal "Installing $TITRE" "$TITRE"
wine $file
POL_SetupWindow_detect_exit
#POL_SetupWindow_message "Please press Next when $TITRE is fully installed" "$TITRE"
POL_SetupWindow_auto_shortcut "$PREFIXE" "teach2000.exe" "$TITRE"
POL_SetupWindow_message "$TITRE has been installed successfully" "$TITRE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/UqHgACgkQ5TH6yaoTykdeFQCgnbIxde0s/M2FBqiLSP/2o4/w
Ti4AoJ5uITakXfhyTyMGO1LRt2lu+KNc
=Z1qf
-----END PGP SIGNATURE-----
