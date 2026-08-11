#!/bin/bash
# Date : (2012-06-04 21-16)
# Last revision : (2013-12-08 22-29)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="descent_3_expansion"
PREFIX="Descent3_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Descent 3"
SHORTCUT_NAME="Descent 3 with Mercenary Expansion"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1245
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Outrage Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6093d28367775a62333247e6a938e7da"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# guess
POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Descent 3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Descent 3/Manual.pdf"
# C:\GOG Games\Descent 3\readme.TXT
# C:\GOG Games\Descent 3\RefCard.pdf
# C:\GOG Games\Descent 3\Editor\D3EDIT.EXE

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Descent 3/" || exit 1
TITLE="$TITLE"

POL_Wine "nglide_config.exe"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKmHf0ACgkQ5TH6yaoTykfTNgCeNkhweoFmrA0iWMXgh3arQ6d6
+tAAoIemEJpdRrSmqdbrWokiV68DcSFD
=sVih
-----END PGP SIGNATURE-----
