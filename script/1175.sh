#!/bin/bash
# Date : (2012-05-10 00-04)
# Last revision : (2014-05-04 21-53)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="might_and_magic_6_limited_edition"
PREFIX="MightAndMagic6Pack_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Might and Magic 6-Pack"
SHORTCUT_NAME1="Might and Magic 1 - Book I"
SHORTCUT_NAME2="Might and Magic 2 - Gates to Another World"
SHORTCUT_NAME3="Might and Magic 3 - Isles of Terra"
SHORTCUT_NAME45="Might and Magic 4-5 - World of Xeen"
SHORTCUT_NAME5A="Might and Magic 5a - Swords of Xeen"
SHORTCUT_NAME6="Might and Magic 6 - The Mandate of Heaven"
SHORTCUT_NAME345PW="Might and Magic 3-4-5 Password reference card"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1175
# For POL_unbase64
POL_RequiredVersion "4.0.17" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.17 is required to install $TITLE"

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "New World Computing Inc. / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "d4790b62542d3b35d8511d7bab09af89"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# For Might&Magic 6
POL_Call POL_Install_vcrun2008

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "1"

# Doesn't hurt ;)
POL_Wine_reboot

# Problem with shortizing subdirectories side-by-side :(
cd "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/" || POL_Debug_Fatal "Game not installed in standard path?"
MIGHTANDMAGIC1="MM1"
mv "Might and Magic 1" "$MIGHTANDMAGIC1" || POL_Debug_Fatal "Game not installed in standard path?"
MIGHTANDMAGIC2="MM2"
mv "Might and Magic 2" "$MIGHTANDMAGIC2" || POL_Debug_Fatal "Game not installed in standard path?"
MIGHTANDMAGIC3="MM3"
mv "Might and Magic 3" "$MIGHTANDMAGIC3" || POL_Debug_Fatal "Game not installed in standard path?"
MIGHTANDMAGIC45="MM4-5"
mv "Might and Magic 4-5" "$MIGHTANDMAGIC45" || POL_Debug_Fatal "Game not installed in standard path?"
MIGHTANDMAGIC5A="MM5A"
mv "Might and Magic - Swords of Xeen" "$MIGHTANDMAGIC5A" || POL_Debug_Fatal "Game not installed in standard path?"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
cpu_core=auto
cpu_type=auto
cpu_cycles='fixed 20000'
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=22050
gus_gus=false
ipx_enable=0
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# FIXME check if useful, GOG seems to have switched to IRQ7 too
# Using SBPro 0x220 7 1 fixes lockups in WoX and SoX
# http://www.gog.com/forum/might_and_magic_series/world_of_xeen_crashes_when_i_sign_in_in_a_tavern
POL_unbase64 <<_EOFCFG_ > "$POL_USER_ROOT/tmp/XEEN.CFG"
BgAgAgIAiAMHAAAAAAAAAAAAAQAAAAAAAQABAA==
_EOFCFG_
if [ -s "$POL_USER_ROOT/tmp/XEEN.CFG" ]; then
	cp "$POL_USER_ROOT/tmp/XEEN.CFG" "$MIGHTANDMAGIC45/XEEN.CFG"
	cp "$POL_USER_ROOT/tmp/XEEN.CFG" "$MIGHTANDMAGIC5A/XEEN.CFG"
fi

cat <<_EOFBAT_ > "$MIGHTANDMAGIC1/MM1.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=1500"
MM.EXE
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$MIGHTANDMAGIC2/MM2.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
loadfix -4 MM2.EXE
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$MIGHTANDMAGIC3/MM3.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
Mm3.com
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$MIGHTANDMAGIC45/MM45.BAT"
@ECHO OFF
xeen.exe
_EOFBAT_

cat <<_EOFBAT_ > "$MIGHTANDMAGIC45/MM45CD.BAT"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC45/GAME1.INST" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC45/GAME2.INST" -t iso
cd world
xeen.exe
_EOFBAT_

POL_Shortcut "MM1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC1/Manual.pdf"
# C:\GOG Games\Might and Magic VI Limited Edition/Might and Magic 1 - Book I\Readme.txt

POL_Shortcut "MM2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC2/Manual.pdf"

POL_Shortcut "MM3.BAT" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC3/Manual.pdf"

POL_Shortcut "MM45.BAT" "$SHORTCUT_NAME45" "$SHORTCUT_NAME45.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME45" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC45/Manual_world_of_xeen.pdf"

POL_Shortcut "MM45CD.BAT" "$SHORTCUT_NAME45 (Full Speech)" "$SHORTCUT_NAME45.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME45 (Full Speech)" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC45/Manual_world_of_xeen.pdf"

POL_Shortcut "SWORDS.EXE" "$SHORTCUT_NAME5A" "$SHORTCUT_NAME5A.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME5A" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC5A/Manual_Swords_of_Xeen.PDF"

POL_Shortcut "MM6.exe" "$SHORTCUT_NAME6" "$SHORTCUT_NAME6.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME6" "$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/Might and Magic 6/Manual.pdf"
# C:\GOG Games\Might and Magic VI Limited Edition\Might and Magic 6\Readme.txt

# FIXME
POL_Shortcut "winebrowser.exe" "$SHORTCUT_NAME345PW" "" "'$WINEPREFIX/drive_c/GOG Games/Might and Magic VI Limited Edition/$MIGHTANDMAGIC3/keys_3_5.pdf'" "Game;RolePlaying;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNmoFwACgkQ5TH6yaoTykeX9wCfRLbnrIiMUmca32W27HZQorG8
rFAAn1NDbbc3cBnHsl4tZp4DD7b0tAxm
=gAWQ
-----END PGP SIGNATURE-----
