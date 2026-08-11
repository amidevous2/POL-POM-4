#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2010-05-23 10-00)
# Wine version used : -
# Distribution used to test : -
# Author : Toumeno 
# Licence : Retail
# Depend : -
#
# CHANGELOG
# [Toumeno] (????-??-?? ??-??)
#   Initial script.
# [NSLW] (2010-05-23 10-00)
#   Updates.
# [Dadu042] (2020-06-06 15-00)
#   Wine 1.1.44 -> system
#   Refresh script

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="RollerCoaster Tycoon 2"
PREFIX="RCT2"

# Starting the script

POL_SetupWindow_presentation "$TITLE" "Infogrames" "www.infogrames.com" "Toumeno" "$PREFIX"

POL_Call POL_Function_NoCDWarning

# Asking for CDROM and checking if it's correct one
POL_SetupWindow_message "Please insert $TITLE media into your disk drive."
POL_SetupWindow_cdrom
cd "$CDROM"
CHECK=$(find . -iwholename ./Setup.exe | cut -d'/' -f2)
POL_SetupWindow_check_cdrom "$CHECK"

POL_Wine_SelectPrefix "$PREFIX"

# Downloading specific Wine
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

# Creating application's own prefix
POL_System_TmpCreate "$TITLE"

# Fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

# Starting installation
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine "$CDROM/$CHECK"
POL_Wine_WaitExit "$TITLE"

# Making shortcut
POL_SetupWindow_menu "What is your language version?" "Languages" "Polish~other" "~"
if [ "$APP_ANSWER" == "Polish" ]; then
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Atari/Rollercoaster Tycoon 2" "rct2.exe" "" "$TITLE"
elif [ "$APP_ANSWER" == "other" ]; then
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Infogrames/RollerCoaster Tycoon 2" "RCT2.exe" "" "$TITLE"
fi

POL_SetupWindow_message "$TITLE has been installed successfully." "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXtu8ngAKCRDlMfrJqhPK
R2F/AJsHQCuEObeTHQDYsRpEUpHU6VNmZACfbPRCGAl9sNuI1wJvQDY1stE+yGo=
=ce9d
-----END PGP SIGNATURE-----
