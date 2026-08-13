#!/bin/bash
# Date : (2012-10-23 19-42)
# Last revision : (2014-07-20 21-39)
# Wine version used : 1.5.8, 1.7.11
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Before 1.5.8: unimplemented function msvcp90.dll.??0?$basic_ostringstream@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QAE@H@Z 
# 1.5.14-1.7.10: weird resize in windowed mode

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="might_and_magic_7_for_blood_and_honor"
PREFIX="MightAndMagic7_gog"
WORKING_WINE_VERSION="1.7.11"

TITLE="GOG.com - Might and Magic 7"
SHORTCUT_NAME="Might and Magic 7 - For Blood and Honor"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1448
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "New World Computing / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a5372e66e7ee6f5e8c93adadaae373eb"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "MM7.exe" "$SHORTCUT_NAME" "" "" "Game;RolePlaying;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VII - For Blood and Honor/MANUAL.PDF"
# C:\GOG Games\Might and Magic VII - For Blood and Honor\Readme.txt
# C:\GOG Games\Might and Magic VII - For Blood and Honor\MAP.PDF
# C:\GOG Games\Might and Magic VII - For Blood and Honor\Reference_card.PDF

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Might and Magic VII - For Blood and Honor/" || exit 1
TITLE="$TITLE"
POL_Wine MM7Setup.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPMHiUACgkQ5TH6yaoTykc6QgCghhR1TYH173HCUSEZ3Q0mmMbg
lSsAmQF+TN0Xj9gQkYkFnminALIXDISM
=wbQP
-----END PGP SIGNATURE-----
