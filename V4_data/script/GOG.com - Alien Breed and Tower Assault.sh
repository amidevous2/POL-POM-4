#!/bin/bash
# Date : (2012-08-18 23-59)
# Last revision : (2013-07-10 13-21)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="alien_breed_tower_assault"
PREFIX="AlienBreed_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Alien Breed and Tower Assault"
SHORTCUT_NAME1="Alien Breed"
SHORTCUT_NAME2="Alien Breed: Tower Assault"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1368
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Team17 Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5ed1a228c99ab0e06885cc083b716b4f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# Problem with shortizing subdirectories side-by-side :(
TOWERASSAULT="Tower Assault"
mv "$GOGROOT/Alien Breed Pack/Alien Breed Tower Assault" "$GOGROOT/Alien Breed Pack/$TOWERASSAULT"

# Tower Assault expects state files in C:\TOWER
[ -d "$WINEPREFIX/drive_c/TOWER" ] || \
  mv "$GOGROOT/Alien Breed Pack/$TOWERASSAULT/TOWER" "$WINEPREFIX/drive_c/"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=dynamic
cpu_cputype=486_slow
cpu_cycles=5000
sblaster_type=sb16
sblaster_base=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
ipx_enable=0
ipx_connection=0
ipx_ipx=false
_EOFCFG_

# Alien Breed: Adlib/Sound Blaster music rather than Roland
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOFDAT_' > "$GOGROOT/Alien Breed Pack/Alien Breed/SETUP.DAT"
AQAAAAEAAAAJAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcAIAIBAEhQS002DhkBOw==
_EOFDAT_
fi

cat <<_EOFBAT_ > "$GOGROOT/Alien Breed Pack/$TOWERASSAULT/TA.BAT"
@ECHO OFF
CONFIG -set "sblaster type=sb1"
CONFIG -set "sblaster irq=5"
LOADFIX -26
TA.EXE
_EOFBAT_

POL_Shortcut "ALIEN.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ArcadeGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Alien Breed Pack/Alien Breed/manual.pdf"
# C:\GOG Games\Alien Breed Pack\Alien Breed\keybindings.txt

POL_Shortcut "TA.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ArcadeGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Alien Breed Pack/$TOWERASSAULT/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Alien Breed Pack/Alien Breed/" || exit 1

TITLE="$TITLE"

POL_Wine CONFIG.EXE
POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdrb8ACgkQ5TH6yaoTykepLwCfUu0CwJoHOv8vvwE0ILDDo5rG
OtEAniq/yaQJ5FI7LvXMTJDcUUGuhzlp
=dRHb
-----END PGP SIGNATURE-----
