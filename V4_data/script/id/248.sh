#!/bin/bash
# Date : (2009-07-30 18-30)
# Last revision : (2010-03-03 17-20)
# Wine version used : 1.0
# Distribution used to test : Ubuntu 9.10
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Trainz Railroad Simulator 2006"
PREFIX="TRS2006"
 
 if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
POLEND="$TITLE a été installé avec succès"
else
INSTALLATION="Installation in progress..."
POLEND="$TITLE has been installed succesfully"
fi
 
POL_SetupWindow_Init 

POL_SetupWindow_presentation "$TITLE" "Anuman Interactive" "http://www.auran.com/TRS2006/index.php" "thib25" "$PREFIX"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Install/setup.exe"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.2"

POL_SetupWindow_wait "$INSTALLATION" "$TITLE"
cd "$CDROM"
POL_Wine "Install/setup.exe"
POL_SetupWindow_detect_exit
 
#Création Icone
 
POL_Shortcut "TRS2006.exe" "$TITLE"
 
POL_SetupWindow_message "$POLEND" "$TITLE"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5VWVcACgkQ5TH6yaoTykd0ewCdE/tnG2/DDLxMmhS/F4jbvvif
BWwAoJmSIsY8nEXjUyd8qsfPk4GuFchy
=9h+c
-----END PGP SIGNATURE-----
