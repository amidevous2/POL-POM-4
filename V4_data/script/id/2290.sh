#!/bin/bash
# Date : (2014-10-11 16-02)
# Wine version used : 1.6.2
# Distribution used to test : OpenSuse 13.1
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Constructor"
PREFIX="Constructor"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"
SHORTCUT_NAME="Constructor"
GOGID="constructor"

POL_SetupWindow_Init
POL_SetupWindow_SetID 
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "System 3" "Retailer: www.gog.com" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "764f989d66969b3ffefcba3e3d15b281"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Game only runs when it's at the root director of C:\
mv "$WINEPREFIX/drive_c/GOG Games/$PREFIX/"* "$WINEPREFIX/drive_c/"


#Creating dosbox configuration file
cat <<'_EOFCONFIG_' >> "$WINEPREFIX/playonlinux_dos.cfg"

sdl_fullscreen=true
sdl_fulldouble=false
sdl_fullresolution=original
sdl_windowresolution=original
sdl_output=overlay
sdl_autolock=true
sdl_sensitivity=80
sdl_waitonerror=true
sdl_priority=higher,normal
sdl_mapperfile=mapper.txt
sdl_usescancodes=true

dosbox_machine=svga_s3
dosbox_captures=capture
dosbox_memsize=32

render_frameskip=0
render_aspect=false
render_scaler=normal2x

cpu_core=auto
cpu_cputype=auto
cpu_cycles=max
cpu_cycleup=1000
cpu_cycledown=1000

mixer_nosound=false
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80

sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=22050

#Dissabling dosbox emulation of features this game doesn't use (provides better speeds on slower computers)
joystick_joysticktype=none
gus_gus=false
speaker_pcspeaker=false
speaker_tandy=off
speaker_disney=false

_EOFCONFIG_


#const.gog is a CD image which must be mounted as a virtual D: drive
cat <<_EOFAUTOEXE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/const.gog" -t iso -fs iso
_EOFAUTOEXE_


POL_Wine_reboot

POL_Shortcut "GAME.EXE" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/manual.pdf"


POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQ5ZvQACgkQ5TH6yaoTykfWyACgonJn1LinlzUuWblZ582EMiH8
I18An2zl+3EzlTMkNn8oyKd3Jaf3o/8d
=hS/z
-----END PGP SIGNATURE-----
