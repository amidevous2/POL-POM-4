#!/bin/bash
# Date : (2012-05-17 16-12)
# Last revision : see changelog
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-17 16-12)
#   Initial script.
# [Dadu042] (2020-01-19 22:50)
#   Wine 1.4.1 -> 3.0.3
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="another_world_20th_anniversary_edition"
PREFIX="AnotherWorld_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Another World: 15th Anniversary Edition"
SHORTCUT_NAME="Another World"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1230
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Eric Chahi / Digital Lounge" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 8683 --bonus "c9e10dbdd5fb26e92a939f03938192cb"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_DirectInput "MouseWarpOverride" "disable"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Another World.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
case "$POL_LANG" in
  uk|sp|fr|it|de)
        MANUAL="Manual_${POL_LANG}.pdf"
        ;;
    *)
        MANUAL="Manual_uk.pdf"
        ;;
esac

POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Another World/$MANUAL"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/\$PROGRAMFILES/GOG.com/Another World/" || exit 1

TITLE="$TITLE"

POL_Wine Config.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYdswAKCRDlMfrJqhPK
R8fCAJsGwJ3a5NY/Ag9H1FugpQ5AT5GgyACgkp17kpc+Vz+aRoI1vztHdocd1Ok=
=hFyq
-----END PGP SIGNATURE-----
