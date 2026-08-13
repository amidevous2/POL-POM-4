#!/bin/bash
# Date : (2012-10-10 18-00)
# Last revision : (2019-11-01)
# Wine version used : 4.0.0
# Distribution used to test : Ubuntu 19.04 amd64
# Author : yaps8
  
# CHANGELOG
# [Dadu042] (2019-11-01)
#   Add shortcut to Config.exe
#   Fix website URL
#
# [wizardofthewest] (2017-03-30)
#   Update game version to 1.7.1
#
# [wizardofthewest] (2016-02-02 11-42)
#   Update game version to 1.7.0
#
# [wizardofthewest] (2016-01-29 11-42)
#   Update game version to 1.6.9
#
# [SuperPlumus] (2013-07-24 11-42)
#   Update gettext messages
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Soldat"
PREFIX="Soldat"
VERSION="171"
MD5SUM="428c9fe24ff4c23bc3d1a40b9c4614ed"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Michal Marcinkowski" "https://soldat.pl/" "yaps8" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
  
POL_System_TmpCreate "$PREFIX"
  
cd "$POL_System_TmpDir"
POL_Download "http://static.soldat.pl/downloads/soldat$VERSION.zip" "$MD5SUM"
unzip "soldat$VERSION.zip"
  
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/SoldatSetup.exe"
POL_Wine_WaitExit "$TITLE"
  
POL_Shortcut "soldat.exe" "$TITLE" "" "" "Game;ActionGame;"
POL_Shortcut "Config.exe" "$TITLE - Config" "" "" "Game;ActionGame;"
  
POL_System_TmpDelete
  
POL_SetupWindow_Close
  
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbvnrwAKCRDlMfrJqhPK
R7aeAKCMcrlG86+n2OlMNGKdQMhyDAHdqwCcDHaVqBAWjh1O9PHlW6LNyKAlW78=
=KqrR
-----END PGP SIGNATURE-----
