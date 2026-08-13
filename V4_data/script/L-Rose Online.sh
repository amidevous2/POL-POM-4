#!/bin/bash
#
# CHANGELOG
# [Quentin Paris] (2010 ?)
#   Initial script.
# [Dadu042] (2020-01-27 23:30)
#   Wine 1.2.3 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# presentation

TITLE="LRose Online"

POL_SetupWindow_Init 
POL_SetupWindow_presentation "LRose Online" "" "http://www.l-rose.net" "Tinou" "LRose"

# Avertissement
POL_SetupWindow_message "You must download the game first\n\nhttp://l-rose.net/?page=telechargement\n\nClick next to continue" "$TITLE"
browser "http://l-rose.net/?page=telechargement"


# Préparation de Wine

POL_Wine_SelectPrefix "LRose"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0.3"

Set_OS "win7"


POL_SetupWindow_browse "Now, select $TITLE install file" "$TITLE"
CHEMIN="$APP_ANSWER"


POL_Wine_WaitBefore "$TITLE"
Set_Managed Off
POL_Wine "$CHEMIN"

POL_Call POL_Install_vcrun2008
# reglage de wine


# CREATION LANCEUR
POL_Shortcut "RoseOnline.exe" "$TITLE" "" "" "Game;"


POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCLZAAKCRDlMfrJqhPK
RwbjAJ9E1xYlhtWlGO9JAKHWF52EJGCo1gCgnd2f4dwd0UN4qAtPpfmkIbIH2A4=
=fC/M
-----END PGP SIGNATURE-----
