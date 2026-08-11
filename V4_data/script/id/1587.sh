#!/bin/bash
# Date : (2013-02-09 21-38)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 12.04.1 LTS 64-bit
# Author : horsemanoffaith
# Depend :
#
# CHANGELOG
# [horsemanoffaith] (2013-02-09 21-38)
#   Initial script.
# [Dadu042] (2020-01-14 22:00)
#   Wine 1.4.1 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
  
TITLE="Zoo Tycoon 2: Zookeeper Collection"
PREFIX="ZT2ZC"
WORKING_WINE_VERSION="3.0.3"

  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Microsoft Games" "http://www.microsoft.com" "horsemanoffaith" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_System_TmpCreate "$PREFIX"

POL_Call POL_Install_MFC42  
   
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "program\ files/microsoft\ games/zoo\ tycoon\ 2/x150_000.z2f"
POL_SetupWindow_wait "$(eval_gettext 'Transferring files from Disc 1')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"
chmod -R 777 "$POL_System_TmpDir"


POL_SetupWindow_message "$(eval_gettext 'Please insert "$TITLE" disc 2')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "program\ files/microsoft\ games/zoo\ tycoon\ 2/x151_000.z2f"
POL_SetupWindow_wait "$(eval_gettext 'Transferring files from Disc 2')" "$TITLE"
cp -R "$CDROM"/* "$POL_System_TmpDir" 
chmod -R 777 "$POL_System_TmpDir"
  
POL_SetupWindow_message "$(eval_gettext 'Please select MORE OPTIONS, then uncheck the RUN "$TITLE" AFTER INSTALLATION option. If you do not, the install will fail!')" "$TITLE"
cd "$POL_System_TmpDir"
rm "00002.tmp"
touch "00002.tmp"
POL_Wine "setup.exe"

POL_System_TmpDelete

POL_Shortcut "ZT.exe" "$TITLE" "" "" "Game;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDPxQAKCRDlMfrJqhPK
R6BCAJ9K2hQIELjUHFqwu/dc/4PblJTMGgCeIVUK/1crL6hlaU3aS04eYK0Drj8=
=Q1QQ
-----END PGP SIGNATURE-----
