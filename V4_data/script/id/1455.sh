#!/bin/bash
# Date : (2012-10-27 22-51)
# Last revision : (2014-07-06 17-58)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="realms_of_arkania_1_2"
PREFIX="RealmsOfArkania1_2_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Realms of Arkania 1 and 2"
SHORTCUT_NAME1="Realms of Arkania 1: Blade of Destiny"
SHORTCUT_NAME2="Realms of Arkania 2: Star Trail"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1455
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Attic Entertainment / Fantasy Productions" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "69496fa7573633b447e88afe135a74ca"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$GOGROOT/Realms of Arkania Pack" || POL_Debug_Fatal "Game not installed in standard path?"

# Problem with shortizing "Realms of Arkania 1" and "Realms of Arkania 2" subdirectories side-by-side :(
ROA1="ROA1"
ROA2="ROA2"
mv "Realms of Arkania 1" "$ROA1"
mv "Realms of Arkania 2" "$ROA2"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
render_frameskip=1
cpu_core=auto
cpu_cputype=auto
cpu_cycles='fixed 12000'
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=44100
gus_gus=false
ipx_ipx=false
render_scaler=normal2x
render_aspect=true
_EOFCFG_

cd "$GOGROOT/Realms of Arkania Pack/$ROA1" || POL_Debug_Fatal "Game not installed in standard path?"

# Select Sound Blaster Pro
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOFCFG_' > "SOUND.CFG"
	IAL//yACBQAAAAAAAAAAAAAAAAA=
	_EOFCFG_
	cp SBPFM.ADV SOUND.ADV
	cp SBPDIG.ADV DIGI.ADV
fi

cat <<_EOFBAT_ > "ROA1.BAT"
@ECHO OFF
cls
intro
bladem
exit
_EOFBAT_

cd "$GOGROOT/Realms of Arkania Pack/$ROA2" || POL_Debug_Fatal "Game not installed in standard path?"

if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOFCFG_' > "DATA/SOUND.CFG"
	IAIFACACBQAAAAAAAAAAAAAAAAA=
	_EOFCFG_
	cp DRIVERS/SBP2FM.ADX DATA/SOUND.ADV
	cp DRIVERS/SBPDIG.ADV DATA/DIGI.ADV
fi

cat <<_EOFBAT_ > "ROA2.BAT"
@ECHO OFF
cls
star
exit
_EOFBAT_

POL_Shortcut "ROA1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Realms of Arkania Pack/$ROA1/passwords.pdf"
# C:\GOG Games\Realms of Arkania Pack\$ROA1\MANUAL.PDF
# C:\GOG Games\Realms of Arkania Pack\$ROA1\Cluebook.pdf

POL_Shortcut "ROA2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Realms of Arkania Pack/$ROA2/passwords.pdf"
# C:\GOG Games\Realms of Arkania Pack\$ROA2\Manual.pdf
# C:\GOG Games\Realms of Arkania Pack\$ROA2\Cluebook.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO5iOwACgkQ5TH6yaoTykcsnwCfVhX6SH4obT2lj7dJ7gU+Rsbu
iK0An2/W9zEfhPWy4WE8kO0PSoXyHFVF
=hVnw
-----END PGP SIGNATURE-----
