#!/bin/bash
# Date : (2012-06-21 21-14)
# Last revision : (2013-07-10 13-36)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="one_unit_whole_blood"
PREFIX="OneUnitWholeBlood_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - One Unit Whole Blood"
SHORTCUT_NAME1="Blood: One Unit Whole Blood"
SHORTCUT_NAME2="Blood: Cryptic Passage"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1269
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Monolith Productions / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "eaa902df6a2dc84e24e208c6c002c4e3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=63
cpu_core=auto
cpu_type=auto
cpu_cycles=max
mixer_rate=44100
mixer_blocksize=2048
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
imgmount D "$WINEPREFIX/drive_c/GOG Games/One Unit Whole Blood/game.ins" -t iso
_EOFAE_

POL_Shortcut "BLOOD.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/One Unit Whole Blood/Manual.pdf"
# C:\GOG Games\One Unit Whole Blood\README.TXT

POL_Shortcut "CRYPTIC.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/One Unit Whole Blood/" || exit 1
TITLE="$TITLE"
POL_Wine SETUP.EXE
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHduYsACgkQ5TH6yaoTykfctQCgqX+zngrdo/TBkJ76jbtEMCXZ
pScAmwf0swKJ3Rne5jp58YnUHkn/ZvRr
=FDxv
-----END PGP SIGNATURE-----
