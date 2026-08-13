#!/bin/bash
# Date : (2013-09-07)
# Last revision : (2014-03-10 23:58)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : VisitntX
#   updated petch
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="i_have_no_mouth_and_i_must_scream"
PREFIX="IHaveNoMouth_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - I Have No Mouth and I Must Scream"
SHORTCUT_NAME1="I Have No Mouth and I Must Scream"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1824
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "The Dreamers Guild / Night Dive Studios" "http://www.gog.com/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "3881dcba2e804cbe28c294a839c334cc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=auto
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=20
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=44100
render_frameskip=1
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=normal2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount d -t iso -fs iso "$GOGROOT/I Have No Mouth, and I Must Scream/NoMouth.dat"
_EOFAE_

POL_Shortcut "S.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/I Have No Mouth, and I Must Scream/I Have No Mouth and I Must Scream - Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMeTmgACgkQ5TH6yaoTykfVUACaA1VReuVeXXnsXXmgVQx8bLQZ
WHQAn3suQ6tNef9Ew2+H1qZ9BtpBnKey
=AVj/
-----END PGP SIGNATURE-----
