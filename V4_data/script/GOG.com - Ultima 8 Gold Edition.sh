#!/bin/bash
# Date : (2013-05-08 21-02)
# Last revision : (2013-06-02 23-54)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Xubuntu 12.10
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_8_gold_edition"
PREFIX="Ultima8_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Ultima 8 Gold Edition"
SHORTCUT_NAME="Ultima 8: Pagan"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1684
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pascal Reinhard" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "379e4ad340f878d2288080191231e9c9"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Language choice
POL_SetupWindow_menu "Choose the game's language" "Language" "English-German-French" "-"
U8LANGUAGE=$APP_ANSWER

# Country code
U8LANG="en"
[ "$U8LANGUAGE" = "German" ] && U8LANG="de"
[ "$U8LANGUAGE" = "French" ] && U8LANG="fr"

# Message about hand-picking the language
if [ "$U8LANG" != "en" ]
then
    POL_SetupWindow_message "$(eval_gettext 'IMPORTANT:
    \n\nOn the installation window coming next, do NOT click the Options button, it would mess up the language selection.')" "$TITLE"
fi

POL_Call POL_GoG_install

GAMEROOT="$GOGROOT/Ultima VIII - Pagan/$U8LANGUAGE/"

# Dosbox config
cat <<_EOFCFG_ > "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_output=overlay
render_aspect=true
render_scaler=advinterp2x
cpu_cycleup=1000
cpu_cycledown=1000
mixer_prebuffer=50
sblaster_sbtype=sbpro1
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
dos_keyboardlayout=$U8LANG
_EOFCFG_

# Set audio default to Sound Blaster Pro
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOFINF_' > "$GAMEROOT/U8.INI"
	AgAgAgUAAQADACAC/////+4U2P+EDToSCA0AAGT+3zpo/qIBCv/fOqIBlQgKABIARgAYADAAAAO4/0luc3RhbGwAdXNpYyBDb25maWd1cmE=
	_EOFINF_
	
	# Copy pilot
	rm "$GAMEROOT/AILXMI.DLL"
	cp "$GAMEROOT/SOUND/A16SBFM.DLL" "$GAMEROOT/AILXMI.DLL"
fi

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
mount D "$GAMEROOT"
_EOFAE_

cat <<_EOFBAT_ > "$GAMEROOT/Ultima8.bat"
@ECHO OFF
D:
U8.EXE
EXIT
_EOFBAT_

POL_Shortcut "Ultima8.bat" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GAMEROOT/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGs56sACgkQ5TH6yaoTykfzjwCfcmfslpCQ6PTZohT4A7oUl4AY
sqsAnjmhJ/w9+vGpcqHvHMTZvRgRVfeV
=44BM
-----END PGP SIGNATURE-----
