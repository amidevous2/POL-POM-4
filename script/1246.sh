#!/bin/bash
# Date : (2012-06-05 20-05)
# Last revision : (2013-07-10 13-21)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="alone_in_the_dark"
PREFIX="AloneInTheDark1_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Alone in the Dark 1"
SHORTCUT_NAME1="Alone in the Dark 1"
SHORTCUT_NAME2="Alone in the Dark 1: Jack in the Dark"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1246
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infogrames Europe SA / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7a615804377edce61d0326d8df2267d8"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
cpu_core=simple
cpu_cputype=pentium_slow
cpu_cycles=11000
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Alone in the Dark/GAME.INST" -t iso
_EOFAE_

POL_Shortcut "INDARK.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Alone in the Dark/manual.pdf"
POL_Shortcut "INDARK2.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "16 1" "Game;ActionGame;"

POL_SetupWindow_Close

# Configurators are only useful to set language
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Alone in the Dark/INDARK/" || exit 1
TITLE="$TITLE"
POL_Wine INSTALL.EXE

exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Alone in the Dark/JACK/" || exit 1
TITLE="$TITLE"
POL_Wine INSTALL.EXE

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdrgAACgkQ5TH6yaoTykeELQCfQ1arODenIqJ+pAECk6Gblfuz
tIsAoKYnQ5a8CtKHAa1vqC4PmJz8/hpu
=Sa6f
-----END PGP SIGNATURE-----
