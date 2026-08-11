#!/bin/bash
# Date : (2012-04-20 21-33)
# Last revision : (2014-06-30 00-09)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="redneck_rampage_collection"
PREFIX="RedneckRampage_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Redneck Rampage Collection"
SHORTCUT_NAME1="Redneck Rampage"
SHORTCUT_NAME2="Suckin' Grits on Route 66"
SHORTCUT_NAME3="Redneck Rampage Rides Again"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1136
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Xatrix Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "f0bd3394c8ff93a52c69e3e05af04b55"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection" || POL_Debug_Fatal "Game not installed in standard path?"

# Problem with shortizing "Redneck Rampage" and "Redneck Rides Again" subdirectories side-by-side :(
REDNECK3="REDNECK3"
mv "Redneck Rides Again" "$REDNECK3"


POL_SetupWindow_VMS "2"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
cpu_core=auto
cpu_cycles=auto
mixer_prebuffer=40
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

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/RR.BAT"
@ECHO OFF
imgmount W "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/REDNECK.inst" -t iso -fs iso
fix.exe
rr.exe
EXIT
_EOFBAT_

cat <<'_EOFBAT_' > "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/RRSETUP.BAT"
@ECHO OFF
fix.exe
setup.exe
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/66.BAT"
@ECHO OFF
imgmount W "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/REDNECK.inst" -t iso -fs iso
fix.exe
ROUTE66.EXE
EXIT
_EOFBAT_

cat <<'_EOFBAT_' > "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/66SETUP.BAT"
@ECHO OFF
fix.exe
ROUTE66M.EXE
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/$REDNECK3/RA.BAT"
@ECHO OFF
imgmount W "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/$REDNECK3/RRRAGAIN.inst" -t iso -fs iso
RA.EXE
EXIT
_EOFBAT_

POL_Shortcut "RR.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/manual.pdf"
# C:\GOG Games\Redneck Rampage Collection\Redneck Rampage\readme.TXT

POL_Shortcut "66.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/ROUTE66.TXT"

POL_Shortcut "RA.BAT" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/$REDNECK3/readme.TXT"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/" || exit 1

TITLE="$TITLE"

POL_Wine RRSETUP.BAT

_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/Redneck Rampage/" || exit 1

TITLE="$TITLE"

POL_Wine 66SETUP.BAT

_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME3"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Redneck Rampage Collection/$REDNECK3/" || exit 1

TITLE="$TITLE"

POL_Wine SETUP.EXE

_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOwpUcACgkQ5TH6yaoTykdBIgCdGvnGcuqvStgu7EdEfKEsbrEF
Uf8An0URwf7tSnUPXbYwLZDmFLiRCnfN
=Qike
-----END PGP SIGNATURE-----
