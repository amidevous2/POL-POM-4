#!/bin/bash
# Date : (2012-05-05 21-11)
# Last revision : (2014-03-02 19-40)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="betrayal_at_krondor"
PREFIX="BetrayalAtKrondor_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Betrayal at Krondor Pack"
SHORTCUT_NAME1="Betrayal at Krondor"
SHORTCUT_NAME2="Betrayal in Antara"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1167
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Dynamix / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "fa85f56b759dedd6999598300f15a68e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# "640x480 256 colors"
POL_SetupWindow_VMS "2"

# Problem with shortizing "Betrayal at Krondor" and "Betrayal in Antara" subdirectories side-by-side :(
# *and* BAK game expects itself in C:\
mv "$GOGROOT/Betrayal Pack/Betrayal at Krondor"/* "$WINEPREFIX/drive_c/"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=8
cpu_core=auto
cpu_cputype=386_slow
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=120
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
oplmode=auto
oplemu=default
oplrate=22050
gus_gus=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_  >"$WINEPREFIX/drive_c/autoexec.bat"
c:
imgmount d "$WINEPREFIX/drive_c/bak.inst" -t iso -fs iso
_EOFAE_

# Enable CDROM music (GOG installer v2 bug?)
if type -t POL_unbase64 > /dev/null; then
	cp "$WINEPREFIX/drive_c/KRONDOR.CFG" "$WINEPREFIX/drive_c/KRONDOR.CFG.orig"
	POL_unbase64 <<-_EOF_ > "$WINEPREFIX/drive_c/KRONDOR.CFG"
	AgEDAB8=
	_EOF_
fi

# Betrayal at Krondor's icon comes from BaK desktop theme, could not find any other
# http://www.sierrahelp.com/Games/KrondorSeries/BaKHelp.html

POL_Shortcut "KRONDOR.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/Manual.pdf"
# C:\GOG Games\Betrayal Pack\Betrayal at Krondor\readme.txt

POL_Shortcut "ANTARAR.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Betrayal Pack/Betrayal in Antara/Manual.pdf"
# C:\GOG Games\Betrayal Pack\Betrayal in Antara\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMTfQAACgkQ5TH6yaoTykdVUgCeMcBzcONIInwttzGXCc+mhFlc
MIIAoIf6MISl6T1jm9nqvLt8zK9ZpKYO
=tASy
-----END PGP SIGNATURE-----
