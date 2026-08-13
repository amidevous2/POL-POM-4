#!/bin/bash
# Date : (2016-07-25 19-51)
# Last revision : (2016-07-25 19-51)
# Wine version used : 1.6.2
# Distribution used to test : Linux Mint 17.3 Rosa
# Author : BiTSHiFT91
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
AUTHOR="BiTSHiFT91"
PRFX="vbalink18"
PROG_NAME="VBA Link 1.8"
PROG_AUTH="VBALink"
PROG_URL="http://www.vbalink.info"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$PROG_NAME" "$PROG_AUTH" "$PROG_URL" "$AUTHOR" "$PRFX"
#select prefix
POL_Wine_SelectPrefix "$PRFX"
#create it
POL_Wine_PrefixCreate
#create temp
#POL_System_TmpCreate
#goto temp
cd "$WINEPREFIX/drive_c/$PROGRAMFILES"
POL_Download "http://www.vbalink.info/download/vbalink180b.zip" "3b7a04dddb2a7b43e0db2e02c649df46"
unzip vbalink180b.zip -d vbalink
rm vbalink180b.zip
#Installing mfc42
POL_Call POL_Install_mfc42
#Create shortcut
POL_Shortcut "VisualBoyAdvance.exe" "$PROG_NAME"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNW8EgAKCRDlMfrJqhPK
RxEsAJ9Ufsj9QA9vArb1JFk9fY7tKn/WTACgpe+4VCqI8sExoDJHZDf/zVWr55s=
=BZuq
-----END PGP SIGNATURE-----
