#!/bin/bash
# Date : (2012-04-29 17-36)
# Last revision : (2014-03-30 21-37)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="simcity_2000_special_edition"
PREFIX="Simcity2000SE_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Simcity 2000 Special Edition"
SHORTCUT_NAME1="Simcity 2000 SE"
SHORTCUT_NAME2="Simcity 2000 SE: Urban Renewal Kit"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1151
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Maxis Software Inc. / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "df14bff3caa6fac2cfb54c1e16399e21"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# "SVGA 256 colors"
POL_SetupWindow_VMS "2"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_autolock=false
cpu_core=dynamic
cpu_cycles=20000
mixer_prebuffer=240
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# Internal SB16 sounds better than external MIDI... And that's one less dependency
cat <<'_EOFCFG_' > "$WINEPREFIX/drive_c/GOG Games/SimCity 2000 Special Edition/SC2000.CFG"
[SimCity 2000 Configuration File]

[Video]
VIDEONAME=VESA Super VGA
VIDEOCARD=ve:31

[Music]
MUSICNAME=Sound Blaster 16
MUSICDRIVER=A32SP2FM.DLL
MUSICADDRESS=220
MUSICIRQ=7
MUSICDMA=1
MUSICDRQ=*

[Sound Effects]
SFXNAME=Sound Blaster 16
SFXDRIVER=A32SBPDG.DLL
SFXADDRESS=220
SFXIRQ=5
SFXDMA=1
SFXDRQ=*

[MIDI Bank]
MUSICFILES=SB

[WillTV Path]
WILLTV=D:\DOS
_EOFCFG_

# Game looks for its CDROM in D:
cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/SimCity 2000 Special Edition/SC2000SE.DAT" -t iso -fs iso
_EOFAE_

echo "EXIT" >> "$WINEPREFIX/drive_c/GOG Games/SimCity 2000 Special Edition/SC2000.BAT"

cat <<'_EOFBAT_' > "$WINEPREFIX/drive_c/GOG Games/SimCity 2000 Special Edition/SCURK.BAT"
@ECHO OFF
SCURK.COM
exit
_EOFBAT_

POL_Shortcut "SC2000.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;Simulation;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/SimCity 2000 Special Edition/manual.pdf"

POL_Shortcut "SCURK.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;Simulation;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlM4engACgkQ5TH6yaoTykftIACfeupgg1j4eSgKqiYOpSuoQ1AH
CH4AoKkZzju/9EdHyNULEcTDoAz2vjuz
=Y+2p
-----END PGP SIGNATURE-----
