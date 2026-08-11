#!/bin/bash
# Date : (2015-11-01)
# Last revision : (2015-11-01)
# Wine version used : 1.7.54
# Distribution used to test : Mac OS El Captain
# Author : Constant51
# Licence : GPLv3
 
TITLE="Dparoic"
PREFIX="dparoic"
WINEVERSION="1.7.54"
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init
 
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "dparoic" "http://" "Constant51" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "winxp"
 
POL_SetupWindow_VMS "512"
 
POL_Call POL_Install_riched20
POL_Call POL_Install_mdac28
 

cd "$WINEPREFIX/drive_c"
POL_Download "$DL_URL"
INSTALLER="${DL_URL##*/}"
 

POL_Wine_WaitBefore "dparoic"
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "dparoic"
 
POL_Shortcut "dparoic.exe" "Paroisse"
 
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlY2RnAACgkQ5TH6yaoTyke8IACgrKQ45mDpYLoyfucP5NGxeCHE
yZYAn2K+0AacV/DCUsfmKm7jc6ZQYuBO
=M0j5
-----END PGP SIGNATURE-----
