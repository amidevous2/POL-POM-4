#!/bin/bash
# Date : (2012-06-25 20-58)
# Last revision : (2014-05-10 11-09)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tyrian_2000"
PREFIX="Tyrian2000_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Tyrian 2000"
SHORTCUT_NAME="Tyrian 2000"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1282
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Eclipse Productions" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9dc73fdfbc8222b6864faff7093cad33"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Timing issues with cpu_cycles=max on my box
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
sdl_autolock=false
dosbox_memsize=8
cpu_core=auto
cpu_cycles=20000
mixer_prebuffer=10
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "tyrian.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Tyrian 2000/TyrianFunDoc/Contents.html"
# C:\GOG Games\Tyrian 2000\readme.txt
# C:\GOG Games\Tyrian 2000\HELPME.TXT
# C:\GOG Games\Tyrian 2000\TyrCheat.doc
# C:\GOG Games\Tyrian 2000\SHIPEDIT.EXE
# C:\GOG Games\Tyrian 2000\SHIPEDIT.TXT


POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Tyrian 2000/" || exit 1
TITLE="$TITLE"
POL_Wine SETUP.EXE

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNt7uMACgkQ5TH6yaoTykc/FACfQ0wdiRPtsu8Uu47kWYh6W1pY
wLoAoKmcZn2JIjUUo2W8ghFsoNxckJwm
=yF2o
-----END PGP SIGNATURE-----
