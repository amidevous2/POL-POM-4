#!/bin/bash
# Date : (2013-03-27 18-28)
# Last revision : (2013-07-10 13-40)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="shadow_warrior_complete"
PREFIX="ShadowWarrior_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Shadow Warrior Complete"
SHORTCUT_NAME1="Shadow Warrior"
SHORTCUT_NAME2="$SHORTCUT_NAME1: Twin Dragon"
SHORTCUT_NAME3="$SHORTCUT_NAME1: Wanton Destruction"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1637
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "3D Realms Entertainment / Devolver Digital" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "f41a6fc4c676eed368c4a2a9f2a940e0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Fix cue file track paths
sed -i.bak -e 's@Music\\@MUSIC/@' "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/GAME.DAT"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
render_aspect=true
dosbox_memsize=32
cpu_core=auto
cpu_cycles=auto
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
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

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/GAME.DAT" -t iso
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/SWARRIOR.BAT"
@ECHO OFF
COPY SW.DAT SW.EXE
SW.EXE
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/dragon/TDRAGON.BAT"
@ECHO OFF
SW.EXE
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/WANTON.BAT"
@ECHO OFF
COPY WANTON.DAT SW.EXE
SW.EXE
EXIT
_EOFBAT_

POL_Shortcut "SWARRIOR.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/Manual.pdf"

POL_Shortcut "TDRAGON.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/Manual.pdf"

POL_Shortcut "WANTON.BAT" "$SHORTCUT_NAME3" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/Manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/" || exit 1
TITLE="$TITLE"

POL_Wine --force-dos Setup.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/dragon/" || exit 1
TITLE="$TITLE"

POL_Wine --force-dos Setup.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME3"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Shadow Warrior Complete/" || exit 1
TITLE="$TITLE"

POL_Wine --force-dos Setup.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdvUUACgkQ5TH6yaoTykc6IwCdHTKDtGcwbtc3pbKiYbUFSAVy
8lgAn1PlrlKcOf2reY/9LujdR5cZAp7q
=DxJG
-----END PGP SIGNATURE-----
