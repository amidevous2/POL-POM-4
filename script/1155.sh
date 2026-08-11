#!/bin/bash
# Date : (2012-04-30 12-44)
# Last revision : (2014-04-20 10-47)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="little_big_adventure"
PREFIX="LittleBigAdventure_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Little Big Adventure"
SHORTCUT_NAME="Little Big Adventure: Twinsen's Adventure"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1155
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adeline Software International / Didier Chanfray SARL" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e05124e733ec0fda16e4f13b88dc37cc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
cpu_core=auto
cpu_cputype=486_slow
cpu_cycles='max 95% limit 80000'
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
imgmount D "$GOGROOT/Little Big Adventure/LBA.DAT" -t iso
mixer cdaudio 50:50
_EOFAE_

POL_Shortcut "RELENT.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Little Big Adventure/manual.pdf"
# C:\GOG Games\Little Big Adventure/README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Little Big Adventure/" || exit 1
TITLE="$TITLE"
POL_Wine Language.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNTjIQACgkQ5TH6yaoTykeUtgCaA+5tl4MYIZGKQeukvxiEVBNS
2YIAmwZ5ONNd7LtK9sXez58kp5WrFWGi
=RIEX
-----END PGP SIGNATURE-----
