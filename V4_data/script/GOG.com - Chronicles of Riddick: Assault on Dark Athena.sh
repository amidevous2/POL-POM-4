#!/bin/bash
# Date : (2012-07-19 20-00)
# Last revision : changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-07-19 20-00)
#   Initial script.
# [Pierre Etchemaite] (2013-07-10 13-30)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.5.13 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_chronicles_of_riddick_assault_on_dark_athena"
PREFIX="ChroniclesOfRiddickAODA_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Chronicles of Riddick: Assault on Dark Athena"
SHORTCUT_NAME="The Chronicles of Riddick: Assault on Dark Athena"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1323
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Starbreeze Studios & Tigon Studios / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a43c0b4d07c955b3b7816f4ab1d5aab8" "80d1351c962f4352dc461d54d5c679f1" "1ecb4fb5c73b7a9b49bcf816c5b16add" "bfc906a2a6202596168204f0df9708ad" "5df4540ecd7a24c6a7c6d0c5f55a3409"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Default interface leaks winprocs and crashes under Wine
POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Pixel aspect: auto => normal
# (auto picks wrong aspect for me, but maybe it's just me)
sed -i.bak -e 's/^VID_PIXELASPECT=-1\.000000/VID_PIXELASPECT=1.000000/' "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/The Chronicles of Riddick - Assault on Dark Athena/Environment.cfg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "DarkAthena.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"

MANUAL="RIDDICK_PC_MANUAL_GB.pdf"
[ "$POL_LANG" = "fr" ] && MANUAL="RIDDICK_PC_MANUAL_FR.pdf"
[ "$POL_LANG" = "es" ] && MANUAL="RIDDICK_PC_MANUAL_ES.pdf"
[ "$POL_LANG" = "de" ] && MANUAL="RIDDICK_PC_MANUAL_DE.pdf"
[ "$POL_LANG" = "it" ] && MANUAL="RIDDICK_PC_MANUAL_IT.pdf"

POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/The Chronicles of Riddick - Assault on Dark Athena/$MANUAL"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/The Chronicles of Riddick - Assault on Dark Athena/" || exit 1
TITLE="$TITLE"
POL_Wine DarkAthena_Launcher.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYYYQAKCRDlMfrJqhPK
RyZpAKCwNr4SK3VqEckIY8zYMZocQwGtrQCgpyV0ZI/ZqGrPFxY7FSg07eamR4g=
=hbKj
-----END PGP SIGNATURE-----
