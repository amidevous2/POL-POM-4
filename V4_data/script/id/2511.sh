#!/bin/bash
 
# Date : (2015-04-11 10-32)
# Last revision : (2015-04-11 10-32)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie (Testing)
# Author : Mark Schreiber mark7@alumni.cmu.edu
# Script licence : GPL v.3
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Mark Schreiber] (2014-10-28 14:30)
#   Initial script.
# [Dadu042] (2014-10-28 14:30)
#   Wine 1.6.1 (outdated) -> 3.0.3
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Close Combat: Cross of Iron"
PREFIX="CloseCombatCrossOfIron"
WINEVERSION="3.0.3"
 
POL_SetupWindow_Init
POL_Debug_Init
 
pushd "$HOME"
 
POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE" ""
 
popd
 
POL_Wine_SelectPrefix "$PREFIX"
 
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_Wine "$APP_ANSWER"
 
POL_Wine_WaitExit "$TITLE"
 
POL_System_TmpCreate "$PREFIX"
 
# Wine currently can't play CC3:CoI videos.  The game will terminate
# if it tries.  Disable videos.
pushd "$POL_System_TmpDir"
 
cat >"$POL_System_TmpDir/cc3settings.reg" <<'EOF'
[HKEY_LOCAL_MACHINE\Software\CSO\Close Combat\3.50]
"PlayVideos"=hex:00,00,00,00
EOF
 
POL_Wine regedit "cc3settings.reg"
 
rm cc3settings.reg
 
popd
 
# CC:CoI currently crashes at at launch at any other resolutions.
Set_Desktop "On" "800" "600"
 
POL_System_TmpDelete
 
POL_Shortcut "CC3.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "$WINEPREFIX/drive_c/Matrix Games/Close Combat Cross of Iron/Close Combat III/Manuals/MANUAL.PDF"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX29KuwAKCRDlMfrJqhPK
RxWNAJ97bKt7pIC+NAGCg5zp1IL3fPsKPwCeMGupVIOuLK87ZqCp67JiBwl0vR8=
=Ar5L
-----END PGP SIGNATURE-----
