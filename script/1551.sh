#!/bin/bash
# Date : (2013-01-23 23-11)
# Last revision : (2013-07-10 13-28)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="bioforge"
PREFIX="Bioforge_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Bioforge"
SHORTCUT_NAME="Bioforge"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1551
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e66a6cc107020a8296e4560167a4a333"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# game expects itself in C:\BIOFORGE
mkdir -p "$WINEPREFIX/drive_c/Bioforge"
mv "$WINEPREFIX/drive_c/GOG Games/Bioforge/Bioforge/"* "$WINEPREFIX/drive_c/Bioforge/"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=35000
mixer_blocksize=2048
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# SB16 Music instead of MPU-401
cd "$WINEPREFIX/drive_c/Bioforge"
cp INSTALL.OPT INSTALL.OPT.orig &&
sed -e 's/MusicCardId=./MusicCardId=3/; s/MusicPort=0x.../MusicPort=0x388/' INSTALL.OPT.orig > INSTALL.OPT &&
cp MUSIC/AILADLIB.DLL AILXMI.DLL

POL_Shortcut "BIOFORGE.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Bioforge/BioForge - Manual.pdf"
# C:\GOG Games\Bioforge\BioForge - Field Personel File.pdf
# C:\GOG Games\Bioforge\BioForge - Reference Card.pdf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/Bioforge/" || exit 1
TITLE="$TITLE"

POL_Wine INSTALL.EXE
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdsEQACgkQ5TH6yaoTykdmjQCdEYLGwNGHwWaCE8CaRmaceA1f
G2oAn30UTr9Da3HTZhrtUfcNy2RDNH23
=R8wl
-----END PGP SIGNATURE-----
