# Date : (2014-09-13 7-30)
# Last revision : (2014-09-13 7-30)
# Wine version used : 1.6.2-dos_support_0.6
# Distribution used to test : Ubuntu
# Author : daemonburrito, demonburrito at gmail dot com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_456"
PREFIX="Ultima456_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Ultima 4, 5, 6"
DEVELOPER="Origin Systems / Electronic Arts"
INSTALL_FILE_HASH="ce753da8c97e34473f281591eaf7f45a"
INSTALL_DIR="Ultima Second Trilogy"
GAME_DIR1="Ultima 4"
GAME_DIR2="Ultima 5"
GAME_DIR3="Ultima 6"
GAME_DIR1_SHORT="Ultima4"
GAME_DIR2_SHORT="Ultima5"
GAME_DIR3_SHORT="Ultima6"

EXEC1="ULTIMA.COM"
EXEC2="ULTIMA.EXE"
EXEC3="ULTIMA6.EXE"
BAT1="ULTIMA4.BAT"
BAT2="ULTIMA5.BAT"
BAT3="ULTIMA6.BAT"
MANUAL1="manual.pdf"
MANUAL2="manual.pdf"
MANUAL3="manual.pdf"
SHORTCUT_NAME1="Ultima 4: Quest of the Avatar (Bundled)"
SHORTCUT_NAME2="Ultima 5: Warriors of Destiny"
SHORTCUT_NAME3="Ultima 6: The False Prophet"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "http://www.gog.com/gamecard/$GOGID" "daemonburrito" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "$INSTALL_FILE_HASH"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install

# Global config
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
midi_mpu401=intelligent

sblaster_irq=5
sblaster_oplmode=auto
sblaster_dma=1
sblaster_sbtype=sbpro1
sblaster_sbbase=220
sblaster_hdma=5

mixer_nosound=false

speaker_disney=true
speaker_pcspeaker=true
speaker_tandy=auto

sdl_fullresolution=desktop
sdl_fullscreen=true
sdl_output=overlay

joystick_joysticktype=auto
joystick_swap34=false
joystick_autofire=false
joystick_timed=true

serial_serial3=disabled
serial_serial4=disabled
serial_serial2=dummy
serial_serial1=dummy

render_aspect=true
_EOFCFG_

[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

#POL_SetupWindow_wait "Moving game dirs to shortened names" "$TITLE"
# workaround for shortize bug
cd "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR"
ln -s "$GAME_DIR1" "$GAME_DIR1_SHORT"
ln -s "$GAME_DIR2" "$GAME_DIR2_SHORT"
ln -s "$GAME_DIR3" "$GAME_DIR3_SHORT"

# Batch file launcher for Ultima 4
cat <<_EOFBAT_ > "$GOGROOT/$INSTALL_DIR/$GAME_DIR1_SHORT/$BAT1"
@ECHO OFF
CONFIG -set "sblaster mixer=true"
CONFIG -set "sblaster oplrate=22050"
CONFIG -set "mixer prebuffer=10"
CONFIG -set "mixer rate=22050"
CONFIG -set "mixer blocksize=2048"
CONFIG -set "speaker pcrate=22050"
CONFIG -set "speaker tandyrate=22050"
CONFIG -set "dos keyboardlayout=none"
CONFIG -set "joystick buttonwrap=true"
CONFIG -set "cpu cycleup=50"
CONFIG -set "cpu core=auto"
CONFIG -set "cpu cycles=500"
CONFIG -set "cpu cycledown=50"
$EXEC1
_EOFBAT_

# Batch file launcher for Ultima 5
cat <<_EOFBAT_ > "$GOGROOT/$INSTALL_DIR/$GAME_DIR2_SHORT/$BAT2"
@ECHO OFF
CONFIG -set "sblaster oplrate=44100"
CONFIG -set "sblaster sbmixer=true"
CONFIG -set "sblaster oplemu=default"
CONFIG -set "mixer prebuffer=20"
CONFIG -set "mixer rate=44100"
CONFIG -set "mixer blocksize=1024"
CONFIG -set "gus ultradir=C:\ULTRASND"
CONFIG -set "gus gusrate=44100"
CONFIG -set "gus gusirq=5"
CONFIG -set "gus gusbase=240"
CONFIG -set "gus gusdma=3"
CONFIG -set "speaker pcrate=44100"
CONFIG -set "speaker tandyrate=44100"
CONFIG -set "sdl mapperfile=mapper.map"
CONFIG -set "joystick buttonwrap=false"
CONFIG -set "cpu core=simple"
CONFIG -set "cpu cycleup=500"
CONFIG -set "cpu cycles=5000"
CONFIG -set "cpu cycledown=500"
CONFIG -set "cpu cputype=386_slow"
$EXEC2
_EOFBAT_

# Batch file launcher for Ultima 6
cat <<_EOFBAT_ > "$GOGROOT/$INSTALL_DIR/$GAME_DIR3_SHORT/$BAT3"
@ECHO OFF
CONFIG -set "sblaster oplrate=44100"
CONFIG -set "sblaster sbmixer=true"
CONFIG -set "sblaster oplemu=default"
CONFIG -set "mixer prebuffer=20"
CONFIG -set "mixer rate=44100"
CONFIG -set "mixer blocksize=1024"
CONFIG -set "gus ultradir=C:\ULTRASND"
CONFIG -set "gus gusrate=44100"
CONFIG -set "gus gusirq=5"
CONFIG -set "gus gusbase=240"
CONFIG -set "gus gusdma=3"
CONFIG -set "speaker pcrate=44100"
CONFIG -set "speaker tandyrate=44100"
CONFIG -set "sdl mapperfile=mapper.map"
CONFIG -set "joystick buttonwrap=false"
CONFIG -set "cpu cycleup=500"
CONFIG -set "cpu core=simple"
CONFIG -set "cpu cycles=3000"
CONFIG -set "cpu cycledown=500"
CONFIG -set "cpu cputype=386_slow"
$EXEC3
_EOFBAT_

POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR1_SHORT/$BAT1" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR1/$MANUAL1"
 
POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR2_SHORT/$BAT2" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR2/$MANUAL2"
 
POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR3_SHORT/$BAT3" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR3/$MANUAL3"
 
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQYlRcACgkQ5TH6yaoTykftNACfTR8I669iq0DK+0OIh0AVc1G7
ZboAoJgJ7EUiJSAGJqy5t2zAdISdPCSf
=GQbT
-----END PGP SIGNATURE-----
