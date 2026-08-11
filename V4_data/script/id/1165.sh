#!/bin/bash
# Date : (2012-05-04 23-09)
# Last revision : (2013-07-10 13-42)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="screamer"
PREFIX="Screamer_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Screamer"
SHORTCUT_NAME="Screamer"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1165
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Graffiti / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9fd7e3070d32a0635572a8a119859ed3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Game expects itself at the root of C:
mv "$WINEPREFIX/drive_c/GOG Games/Screamer/"* "$WINEPREFIX/drive_c/"

# Screamer is a bit crash-prone http://www.dosbox.com/comp_list.php?showID=723
mv "$WINEPREFIX/drive_c/GFX/MAP5H.DAT" "$WINEPREFIX/drive_c/GFX/real.MAP5H.DAT"
cp "$WINEPREFIX/drive_c/GFX/MAP5L.DAT" "$WINEPREFIX/drive_c/GFX/MAP5H.DAT"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cycles='max 95% limit 120000'
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
ipx_ipx=false
_EOFCFG_

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
IPXNET STARTSERVER
imgmount d "$WINEPREFIX/drive_c/SCREAM.DAT" -t iso -fs iso
_EOFAE_

# "VGA 256 colors"
POL_SetupWindow_VMS "2"

POL_Shortcut "STARTH.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/manual.pdf"
# C:\GOG Games\Screamer\README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/" || exit 1
TITLE="$TITLE"
POL_Wine SETUP.EXE

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJa0LcACgkQ5TH6yaoTykfGFwCeI7GrqUkx72AfHPstyd8VR10N
EvQAn0FaC/WnLXk4jTYXbXfFpfAVgDKw
=UJ8j
-----END PGP SIGNATURE-----
