#!/bin/bash
# Date : (2012-08-02 15-20)
# Last revision : (2014-04-20 10-10)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="little_big_adventure_2"
PREFIX="LittleBigAdventure2_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Little Big Adventure 2"
SHORTCUT_NAME="Little Big Adventure 2: Twinsen's Odyssey"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1342
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adeline Software International / Didier Chanfray SARL" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "45bde8d21dc3101ac6d712fd4b3161b6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
cpu_core=auto
cpu_cputype=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
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

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$GOGROOT/Little Big Adventure 2/LBA2.DAT" -t iso
_EOFAE_

# LBA2.EXE is detected as Windows executable
cat <<_EOFBAT_ > "$GOGROOT/Little Big Adventure 2/LBA2.BAT"
@ECHO OFF
LBA2.EXE
EXIT
_EOFBAT_

POL_Shortcut "LBA2.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Little Big Adventure 2/manual.pdf"
# C:\GOG Games\Little Big Adventure 2\README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Little Big Adventure 2/" || exit 1
TITLE="$TITLE"
POL_Wine Language.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNTiTMACgkQ5TH6yaoTykdSYQCgodZpohNMs8hPYguWaFzEKmlI
drgAn1SM9o7hSnT+ViVvBQHImonhMQ9b
=RInU
-----END PGP SIGNATURE-----
