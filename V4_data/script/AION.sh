#!/bin/bash
# Date : (2013-09-10 20-36)
# Last revision : see changelog
# Distribution used to test : Xubuntu 18.04
# Author: SuperPlumus and legluondunet
  
# CHANGELOG
# [SuperPlumus] (2013-09-10 20-36)
#   Initial writting (based on http://www.playonlinux.com/fr/topic-9394.html).
# [Legluondunet] (2014 ?)
#   ?
# [Ronin DUSETTE] (2015)
#   Added declaration for WinXP, just to make sure that it defaults to that. 
#   Added Set_OS command earlier. 
#   Updating to fix bugs: http://www.playonlinux.com/en/issue-4998.html
# [Playpal] (2016)
#   The game launcher requires dotnet to display the web page inside correctly, I don't know if they game actually needs it. Tested with wine stable 1.8.2.
# [Dadu042] (2019-05-23)
#   Fix wine prefix creation fail on Xubuntu 19.04
# [Dadu042] (2019-06-03)
#   Fix 'AION_GameForgeLiveSetup.exe' does not open on the display (only blue background).
#   Change Set_Arch from Auto to x86. Add POL functions (msxml3, corefonts)
# [Dadu042] (2020-07-29)
#   [IMPROVED] POL_Shortcut
#   [CHANGED] Wine 2.22 -> 3.0.3 (not tested but should work. Perhaps 4.0.4 should be OK with POL v4.3)
#   [IMPROVED] Changelog
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="AION"
PREFIX="Aion"
WORKING_WINE_VERSION="3.0.3"
  
POL_SetupWindow_Init
  
# for POL_LoadVar_ScreenResolution
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE 4.2.12 is required to install $TITLE"
  
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "NCsoft" "" "SuperPlumus and Legluondunet" "$PREFIX"

##################
# LET'S GO       #
##################

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_System_TmpCreate "$PREFIX"
  
POL_LoadVar_ScreenResolution
Set_Desktop "On" "$ScreenWidth" "$ScreenHeight"

POL_Call POL_Install_vcrun2005
POL_Call POL_Install_msxml3
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma

##################
# REGISTRY HACK  #
##################

cat << EOF > "$POL_System_TmpDir/RegModif.reg"
REGEDIT4
  
[HKEY_CURRENT_USER\Software\Gameforge4d\GameforgeLive\MainApp]
"ActionOnCloseWindow"="Quit"
EOF
regedit "$POL_System_TmpDir/RegModif.reg"

# 2014 hack (Wine 1.7.36). Related to ? : http://www.gamersonlinux.com/forum/threads/wine-1-7-51-steam-dwrite-fixed.1523/
POL_Wine_OverrideDLL disabled dwrite
  
##########################
# DOWNLOAD then INSTALL  #
##########################

cd "$WINEPREFIX/drive_c"
POL_Download "http://dlcl.gfsrv.net/gfl/AION_GameforgeLiveSetup.exe" ""
POL_Wine_WaitBefore "$TITLE"
POL_Wine "AION_GameforgeLiveSetup.exe"
POL_Wine_WaitExit "$TITLE"
  
POL_System_TmpDelete
  
POL_Shortcut "GameforgeLive.exe" "$TITLE" "" "" "Game;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXyFEqQAKCRDlMfrJqhPK
RzsRAJ4qpUe1+U+RiY1S30Fx72AFzIovGQCbBSBy4yEsiVG1uWs3J9ZmGyCTTHw=
=gBLv
-----END PGP SIGNATURE-----
