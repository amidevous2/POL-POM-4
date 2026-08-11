#!/bin/bash
# Date : (2013-02-24 12-50)
# Last revision : (2013-12-13 20-45)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="pro_pinball_timeshock"
PREFIX="ProPinballTS_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Pro Pinball Timeshock"
SHORTCUT_NAME="Pro Pinball Timeshock"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1589
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cunning Developments / Strategy First" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "b2111582b23d466c64d78c79497e2c39"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# "SVGA"?
POL_SetupWindow_VMS "2"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=63
cpu_core=auto
cpu_cycles=max
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
_EOFCFG_

cat <<_EOFBAT_ > "$GOGROOT/Pro Pinball - Timeshock/SHOCK.BAT"
@ECHO OFF
imgmount D "PPTIME~1.INS" -t iso
SHOCK.EXE
_EOFBAT_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "SHOCK.BAT" "$SHORTCUT_NAME (MS-DOS)" "$SHORTCUT_NAME.png" "" "Game;Simulation;"
POL_Shortcut_Document "$SHORTCUT_NAME (MS-DOS)" "$GOGROOT/Pro Pinball - Timeshock/manual.pdf"

POL_Shortcut "Timeshock!.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;Simulation;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Pro Pinball - Timeshock/manual.pdf"

# C:\GOG Games\Pro Pinball - Timeshock\README.TXT
# C:\GOG Games\Pro Pinball - Timeshock\tech_manual.PDF

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKrZJcACgkQ5TH6yaoTykfggACgoJicG3t6yVtT99y9ueScpkXC
oA8AoLHAvqhz3zuQjw2C075+VTdkBN7R
=01SE
-----END PGP SIGNATURE-----
