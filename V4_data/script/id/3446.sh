#!/usr/bin/env playonlinux-bash
# Date : (2019-01-08 20-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : 
# Author : see changelog
#
# CHANGELOG
# [Danilo] (2019-01-08 20-00)
#   Initial script.
# [Danilo] (2020-06-30 12-00)
#   Update the download URL.
# [Dadu042] (2020-06-30 16-00)
#   Wine 3.0.4 -> 3.0.3 (because POL v4.2 support up to v3.0.3 and still installed on some Linux OS. Wine 3.0.4 is only available from POL v4.3).
#   Add software categorie
# [Dadu042] (2020-06-30 16-10)
#   URL checksum must be lowercase.
# [Danilo] (2020-07-07 18-00)
#   MD5 Version 3.1.1.
# [Danilo] (2020-07-14 18-00)
#   MD5 Version 3.1.2.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Visualizza Fattura Elettronica"
SOFTWARE_URL="https://visualizzafatturaelettronica.it"
PREFIX="visfatt"

#WINEVERSION="3.0.3"

EDITOR="MIGG Informatica & Ricerca"
EDITOR_URL="https://migg.it"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
#POL_Wine_PrefixCreate "$WINEVERSION"

mkdir -p "$WINEPREFIX/drive_c/Migg"
cd "$WINEPREFIX/drive_c/Migg"
POL_Download "https://migg.it/files/demo/VisFattFree.exe" "224a3b23eedbc39c7071ff590b8b7248" # v3.1.2

POL_Wine_WaitBefore "$TITLE"
#unzip "VisFattFree.exe" || POL_Debug_Error "Unable to extract $TITLE"
POL_Wine VisFattFree.exe
POL_Wine_WaitExit "$TITLE"
POL_Call POL_Install_LunaTheme

POL_Shortcut "VisFatt.exe" "$TITLE" "" "" "Office;"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzZDugAKCRDlMfrJqhPK
R7B4AJ4waCmyw75fKLRIgBgshRX2g+8dvQCeN4fRLjtkatKxwMAg49SW/pXQJ9Q=
=oC5e
-----END PGP SIGNATURE-----
