#!/bin/bash
# Date : (2012-06-13 19-32)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-13 19-32)
#   Initial script.
# [Pierre Etchemaite] (2014-02-09 14:20)
#   ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.5.0 -> 2.22

# Problem with Wine 1.5.1+
# http://bugs.winehq.org/show_bug.cgi?id=30328

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="arx_fatalis"
PREFIX="ArxFatalis_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Arx Fatalis"
SHORTCUT_NAME="Arx Fatalis"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1256
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Arkane Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5be0898e71632e46ca430d7a32d0179a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_DirectInput "MouseWarpOverride" "force"

# Disable forcegdi, remove keyboard settings to revert to defaults
cat <<'_EOFCFG_' | perl -pe 's/\n/\r\n/' > "$GOGROOT/Arx Fatalis/cfg_default.ini"
[VIDEO]
resolution=800x600
full_screen=1
bump=1
_EOFCFG_

cat <<_EOFFUNC_ > "$GOGROOT/Arx Fatalis/arx_funcs"

read_arx_settings () {
  [ -z "\$WINEPREFIX" ] && POL_Debug_Fatal 'read_arx_settings: \$WINEPREFIX must be set'
  perl -ne 'print "RESOLUTION=\$1\n" if /^resolution=(\d+x\d+)/' "$GOGROOT/Arx Fatalis/cfg_default.ini"
}

write_arx_settings () {
  [ -z "\$WINEPREFIX" ] && POL_Debug_Fatal 'read_arx_settings: \$WINEPREFIX must be set'
  perl -i.bak -pe 's/^resolution=\d+x\d+/resolution='"\$RESOLUTION"'/' "$GOGROOT/Arx Fatalis/cfg_default.ini"
}

_EOFFUNC_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "ARX.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Arx Fatalis/manual.pdf"
# C:\GOG Games\Arx Fatalis\readme.txt
# C:\GOG Games\Arx Fatalis\map.pdf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Arx Fatalis/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

source arx_funcs
eval \$(read_arx_settings)

# drop 320x200, 400x300 and 512x384
POL_SetupWindow_menu_list "\$(eval_gettext 'Select game resolution:')" "\$TITLE" "640x480~800x600~1024x768~1152x864~1280x1024" "~" "\$RESOLUTION"
[ "\$APP_ANSWER" != "\$RESOLUTION" ] && RESOLUTION="\$APP_ANSWER" write_arx_settings

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYghwAKCRDlMfrJqhPK
R7grAJ9uIZA9px0gjslATHoHibDcsszLfACgmzsDkMvbfYCPd7At4FcNAIJz/PQ=
=ZsV+
-----END PGP SIGNATURE-----
