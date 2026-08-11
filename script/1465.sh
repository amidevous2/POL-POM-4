#!/bin/bash
# Date : (2012-11-17 19-29)
# Last revision : (2013-07-10 13-31)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="crusader_no_remorse"
PREFIX="CrusaderNoRemorse_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Crusader: No Remorse"
SHORTCUT_NAME="Crusader: No Remorse"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1465
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b106e8ba0e398dbed4963d7ceb701c13"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
cpu_core=auto
cpu_cycles=max
render_aspect=true
render_frameskip=1
mixer_prebuffer=240
sblaster_type=sb16
sblaster_base=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/GOG Games/Crusader No Remorse/GAME.GOG" -t iso -fs iso
_EOFBAT_

POL_Shortcut "CRUSADER.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Crusader No Remorse/manual.pdf"
# C:\GOG Games\Crusader No Remorse\README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Crusader No Remorse/" || exit 1
TITLE="$TITLE"
POL_Wine INSTALL.EXE
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdsYkACgkQ5TH6yaoTykdeUACghmEtFThnq3LTK4YZmtif57yk
61cAoKTZ/oZnxQVBS/pI6UQwbjTGogd7
=Nzur
-----END PGP SIGNATURE-----
