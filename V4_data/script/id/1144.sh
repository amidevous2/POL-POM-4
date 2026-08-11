#!/bin/bash
# Date : (2012-04-22 21-59)
# Last revision : (2014-07-06 09-23)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="realms_of_the_haunting"
PREFIX="RealmsHaunting_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Realms of the Haunting"
SHORTCUT_NAME="Realms of the Haunting"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1144
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Gremlin Interactive Ltd. / Funbox Media" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "fe4fb6831115b28143d16bf78da26148"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
render_aspect=true
dosbox_memsize=16
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
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# The game expects itself in C:\ROTH and CDROM in C:\DATA
mv "$GOGROOT/Realms of the Haunting/"{ROTH,DATA,mapper.txt} "$WINEPREFIX/drive_c/"

POL_Shortcut "ROTH/ROTH.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "@roth.res" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Realms of the Haunting/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO5OUkACgkQ5TH6yaoTykdW8QCgohpK+dPbjC9xUBcsmx3sKP2M
BN0AnAz77g7s2Gg3lcn85PwYoohJ1mqR
=OEYP
-----END PGP SIGNATURE-----
