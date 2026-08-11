#!/bin/bash
# Date : (2013-01-27 21-58)
# Last revision : (2013-07-10 13-42)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="wing_commander_3_heart_of_the_tiger"
PREFIX="WingCommander3_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Wing Commander 3: Heart of the Tiger"
SHORTCUT_NAME="Wing Commander 3: Heart of the Tiger"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1554
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1d723903aca5fbd555ad407cddf6924d" "07a937795137de0e6c71644671bd8f22" "21955f4041ea3aa43ed1ffea73301f3c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Game looks for itself in C:\WC3\
mkdir -p "$WINEPREFIX/drive_c/WC3"
mv "$WINEPREFIX/drive_c/GOG Games/Wing Commander III - Heart of the Tiger/WC3"/* "$WINEPREFIX/drive_c/WC3/"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
cpu_core=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=10000
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
ipx_ipx=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Wing Commander III - Heart of the Tiger/DATA.DAT" -t iso
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander III - Heart of the Tiger/WC3.BAT"
@ECHO OFF
D:
wc3.exe
EXIT
_EOFBAT_

POL_Shortcut "WC3.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Wing Commander III - Heart of the Tiger/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Wing Commander III - Heart of the Tiger/" || exit 1
TITLE="$TITLE"

POL_Wine "WC3.BAT" "-install"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJa0WsACgkQ5TH6yaoTykdrwgCfXfbqJs488rLnX3NTw41K8tAW
lp8An2w0kXXxN1po1DwlpUhLyv5xHs7F
=m/dh
-----END PGP SIGNATURE-----
