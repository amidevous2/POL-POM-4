#!/bin/bash
# Date : (2012-11-17 14-13)
# Last revision : (2014-07-20 18-59)
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

GOGID="might_and_magic_8_day_of_the_destroyer"
PREFIX="MightAndMagic8_gog"
WORKING_WINE_VERSION="1.7.11"

TITLE="GOG.com - Might and Magic 8"
SHORTCUT_NAME="Might and Magic 8 - Day of the Destroyer"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1463
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "New World Computing / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3ae5a50c779b0932049b77aad2b86370"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "MM8.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VIII - Day of the Destroyer/MANUAL.PDF"
# C:\GOG Games\Might and Magic VIII - Day of the Destroyer\Reference_card.PDF
# C:\GOG Games\Might and Magic VIII - Day of the Destroyer\Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Might and Magic VIII - Day of the Destroyer/" || exit 1

TITLE="$TITLE"
POL_Wine MM8Setup.Exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPMFQwACgkQ5TH6yaoTykc5WACeNhYZ4TLhc7LRZ1FKtPtGhzr2
iq0An3qiznvap44Ibg1IauVGyLsiQS16
=Jzre
-----END PGP SIGNATURE-----
