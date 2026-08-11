#!/bin/bash
# Date : (2012-03-17 10-47)
# Last revision : see CHANGELOG
# Wine version used : 1.3.27, 1.7.12
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
# Logo screen does not show up starting from Wine 1.3.28:
# http://bugs.winehq.org/show_bug.cgi?id=28869
# Tested up to Wine 1.5.0

# CHANGELOG
# [Pierre Etchemaite] (2014-02-07 22-22)
#   First script.
# [Daviot] (2016-07-04)
#   Adds an additional shortcut for graphics configuration .exe program.
# [Dadu042] (2019-12-29)
#   Wine 1.7.12 -> system (because of POL user reviews and Appdb.winehq.org).
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="neverwinter_nights_diamond_edition"
PREFIX="NeverwinterNights_gog"
WORKING_WINE_VERSION=""
 
TITLE="GOG.com - Neverwinter Nights Diamond Edition"
SHORTCUT_NAME="Neverwinter Nights Diamond Edition"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1099
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Bioware / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "e7d063a2c892519dc431fc84c3611a65" "2b6bec0df8d2f1755876407069f6ae43" "db2c1e75b087e43fa5895bcc70fca8b9"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install "/nogui"
 
 
# GoG work!
Set_OS winxp
 
POL_SetupWindow_VMS "16"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
POL_Shortcut "nwmain.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"

POL_Shortcut "nwconfig.exe" "$SHORTCUT_NAME - Config" "" "" "Game;RolePlaying;"

POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Neverwinter Nights Diamond Edition/NWN_OnlineManual.pdf"
# C:\GOG Games\Neverwinter Nights Diamond Edition\readme.txt
# C:\GOG Games\Neverwinter Nights Diamond Edition\NWNHordes_Manual.pdf
# C:\GOG Games\Neverwinter Nights Diamond Edition\NWN_SoU_OnlineManual.pdf
 
POL_SetupWindow_Close
 
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"
 
POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Neverwinter Nights Diamond Edition/" || exit 1
TITLE="$TITLE"
 
POL_Wine nwconfig.exe
exit 0
_EOF_
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgig/wAKCRDlMfrJqhPK
RxVNAJ9r5C+GR42pACdwnAhZOxwSCIq+QQCdHfGxdKGrIxosollYnW/la6xpSoQ=
=EjjC
-----END PGP SIGNATURE-----
