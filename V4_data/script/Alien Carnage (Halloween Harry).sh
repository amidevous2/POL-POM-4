#!/bin/bash
# Date : (2012-12-08 15-15)
# Last revision : (2012-12-08 16-12)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="AlienCarnage"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="Alien Carnage (Halloween Harry)"
URL="http://www.3drealms.com/carnage/"
SHORTCUT_NAME="Alien Carnage"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1508
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Interactive Binary Illusions / Apogee Software" "$URL" "Pierre Etchemaite" "$PREFIX"

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_Download "ftp://ftp.3drealms.com/freeware/acfreew.zip" "38317a6991aaf4387519e73cd0ce3f3c"
    ARCHIVE="$POL_USER_ROOT/tmp/acfreew.zip"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine_WaitBefore "$TITLE"

cd "$WINEPREFIX/drive_c"
unzip "$ARCHIVE"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_machine=vgaonly
cpu_cycles=4000
render_aspect=true

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

if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-_EOF_ > "HARRY.CFG"
	AgAAAAAAIAIHAmQAAAAAABQAAgEBAAAAAAAAAAACAAAAAAAAAAAAAAEAS01IUB04AAAAAQA=
	_EOF_
fi

POL_Shortcut "CARNAGE.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" ""
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/Alien Carnage.pdf"

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlDDWW0ACgkQ5TH6yaoTykc6ggCfVGRnEngC0gG673WHfN3Y+xWX
3uUAnjdSBAfIeHgbCDlYqBbG1JTLoRAv
=+S0y
-----END PGP SIGNATURE-----
