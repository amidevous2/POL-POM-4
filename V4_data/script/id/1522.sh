#!/bin/bash
# Date : (2012-12-28 01-16)
# Last revision : (2013-07-10 13-39)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# FIXME: no support for 3DFX, requires DOSBOX with Glide patch

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="screamer_2"
PREFIX="Screamer2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Screamer 2"
SHORTCUT_NAME="Screamer 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1522
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Graffiti / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ebaec28d87f3eade27a5124c1f038799"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Screamer 2 expects itself in C:\
mv "$WINEPREFIX/drive_c/GOG Games/Screamer 2"/* "$WINEPREFIX/drive_c/"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cycles=auto
render_frameskip=1
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=1024
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ >> "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/GAME.DAT" -t iso
_EOFBAT_

cat <<_EOFBAT_ >> "$WINEPREFIX/drive_c/setup.bat"
@ECHO OFF
CONFIG -set "cpu cycles=75000"
setup.exe
EXIT
_EOFBAT_

POL_Shortcut "START65H.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame;"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/" || exit 1
TITLE="$TITLE"

POL_Wine "setup.bat"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdvPUACgkQ5TH6yaoTykfiGQCfTxMRnIhSj5USIALGxyQWt3vv
HHQAoJKS3rrwHa5JG85s2NP9woZjUYqp
=OQpR
-----END PGP SIGNATURE-----
