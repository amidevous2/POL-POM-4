#!/bin/bash
# Date : (2012-02-03 21-27)
# Last revision : (2014-02-23 21-21)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="broken_sword_3__the_sleeping_dragon"
PREFIX="BrokenSword3_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Broken Sword 3: The Sleeping Dragon"
SHORTCUT_NAME="Broken Sword 3: The Sleeping Dragon"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1102
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "afcbb7158f1d1ca1ffd43659680fc00a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# http://www.gog.com/forum/broken_sword_the_smoking_mirror/broken_sword_the_sleeping_dragon_freezes_on_startup
#cat <<'_EOFINI_' > "$POL_USER_ROOT/tmp/refresh60hz.reg"
#REGEDIT4
#
#[HKEY_LOCAL_MACHINE\Software\Microsoft\DirectDraw]
#"ForceRefreshRate"=dword:0000003c
#_EOFINI_
#POL_Wine regedit "$POL_USER_ROOT/tmp/refresh60hz.reg"
#rm "$POL_USER_ROOT/tmp/refresh60hz.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BSTSD.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Broken Sword - The Sleeping Dragon/Manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Broken Sword - The Sleeping Dragon/" || exit 1
TITLE="$TITLE"
POL_Wine BSTSD.exe -safevideomode
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMPoP0ACgkQ5TH6yaoTykffgACgoUq7Y8HNRxwsjWRNVdtxYYKU
dUMAn3jaXsRovfKc3t+dXDDZchp+6LxE
=Fyis
-----END PGP SIGNATURE-----
