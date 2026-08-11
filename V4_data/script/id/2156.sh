#!/bin/bash
#
# CHANGELOG
# [Tinou] (2014-07-11)
#   Initial writting.
# [Dadu042] (2019-06-29)
#   Wine 3.0.4 -> 4.0.1
# [Dadu042] (2019-10-05)
#   Wine 4.0.1 -> 4.0.2
#   Add software category
# [Dadu042] (2019-12-14)
#   Wine 4.0.2 -> 4.0.3 (4.0.2 not avaiable on POM).
#  POL_RequiredVersion "4.2.12" -> 4.3.4

#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="MetaTrader 5"
PREFIX="metatrader5"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://www.metatrader5.com/" "Tinou" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "4.0.3"

POL_Call POL_Install_LunaTheme
  
cd "$WINEPREFIX/drive_c"
POL_Download "http://files.metaquotes.net/metaquotes.software.corp/mt5/mt5setup.exe"

POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "mt5setup.exe"
POL_Wine_WaitExit "$TITLE"
  

POL_Shortcut "terminal.exe" "$TITLE" "" "" "Finance;"

# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"    

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfT7+AAKCRDlMfrJqhPK
R6kZAJ9YMmDPtuPdGc8GUSwF2fnuKORLPACfaKx44421WVmNX2sADfprWWSmuJU=
=7EMj
-----END PGP SIGNATURE-----
