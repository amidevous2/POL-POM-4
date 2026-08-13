#!/bin/bash
# Date : (2013-05-22 22-00)
# Last revision : (2014-04-03 20-22)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Xubuntu 13.04
# Authors : Pascal Reinhard <dev@ovocean.com>, TonyFlow <tonyflow@rhcp.net>
#   Updated by petch
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dungeon_keeper"
PREFIX="DungeonKeeper_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Dungeon Keeper"
SHORTCUT_NAME1="Dungeon Keeper: Dungeon Keeper Gold"
SHORTCUT_NAME2="Dungeon Keeper: Deeper Dungeons"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1712
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "36ecc458f1d3e830f738853d1b992dc6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


GOGPATH="$GOGROOT/Dungeon Keeper Gold"
  
# game expects itself in C:\
mv "$GOGPATH/"* "$WINEPREFIX/drive_c/"
GOGPATH="$WINEPREFIX/drive_c"

# Enable the high-resolution mode by default
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-_EOF_ > "$GOGPATH/SAVE/SETTINGS.DAT"
	AAQDAAEBf1oBAAANAAAAyADQAMsAzQAdACoA0wDRAMcAzwAUACYAJgEZARQEFAEjABEAHwAUAiIAMAAjASIBMAEhAB4AKgBSAA4AGQAyAAEABg==
	_EOF_
	POL_SetupWindow_message "$(eval_gettext 'Tip: The high-resolution mode has been activated, if it is too slow, you can disable it by pressing Alt+R while in game.)')" "$TITLE"
else
	POL_SetupWindow_message "$(eval_gettext 'Tip: You can enable a higher-resolution mode by pressing Alt+R during the game.')" "$TITLE"
fi

# Dosbox config
cat <<_EOFCFG_ > "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
render_aspect=true
render_frameskip=1
dosbox_memsize=30
cpu_core=auto
cpu_cputype=486_slow
cpu_cycles=80000
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_type=sb16
sblaster_base=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
gus_gus=false
_EOFCFG_

# Batch launcher with image disk mount
cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
imgmount D "$GOGPATH/GAME.INST" -t iso -fs iso
_EOFBAT_

POL_Shortcut "KEEPER.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGPATH/manual.pdf"

POL_Shortcut "DEEPER.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGPATH/manual.pdf"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlM9rUAACgkQ5TH6yaoTykeq3wCfWkUlGmun8Pdb2NbwsmrTvTDk
cKAAnjO0mc9PtViXmOfvifESMEcLQPK/
=FgUk
-----END PGP SIGNATURE-----
