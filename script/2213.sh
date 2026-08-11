#!/bin/bash
# Date : (2014-08-01 18:50:55)
# Last revision : (2014-08-03 11:48:47)
# Wine version used : 1.6.2-dos_support_0.6
# Distribution used to test : Ubuntu 14.04
# Author : Victor Ochoa (kanito8a)
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# CONSTANTS
GOGID="anvil_of_dawn"
PREFIX="AnvilofDawn_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"
TITLE="GOG.com - Anvil of Dawn"
DEVELOPER="DreamForge Intertainment / Ubisoft"
INSTALL_FILE_HASH="8ecba50452dbe230a2e1a868be422dc6"
INSTALL_DIR="Anvil of Dawn"
EXEC="ANVIL.EXE"
MANUAL="Anvil of Dawn - Manual.pdf"
SHORTCUT_NAME="Anvil of Dawn"
 
# IMAGES SETUP
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups
/$PREFIX/left.png" "$TITLE"
 
# INSTALLATION
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "http://www.gog.com/gamecard/$GOGID" "Victor Ochoa" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "$INSTALL_FILE_HASH"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_GoG_install
 
# DOSBOX AUTOEXEC
cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount d "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/Anvil.dat" -t iso -fs iso
_EOFAE_
 
# DOSBOX CONFIG
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=20000
render_aspect=true
mixer_blocksize=1024
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
_EOFCFG_
 
# SHORTCUTS
POL_Shortcut "GOG Games/$INSTALL_DIR/$EXEC" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-p" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$MANUAL"
 
# THE END
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPgp/sACgkQ5TH6yaoTykfYfACdG3xNn/H7j7dgdNzp4vtmG0ip
q7wAoLLuMjTnLFzUR0k3IC1kNlodcCod
=Rqyj
-----END PGP SIGNATURE-----
