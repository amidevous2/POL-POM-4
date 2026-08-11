#!/bin/bash
# Date : (2012-05-15 21-41)
# Last revision : (2014-05-18 23-24)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tex_murphy_under_a_killing_moon"
PREFIX="TexMurphyUAKM_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Tex Murphy: Under a Killing Moon"
SHORTCUT_NAME="Tex Murphy: Under a Killing Moon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1199
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Access Software / Wordplay LLC" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6b61a36ec81339e0d7bc456e4f211ab3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=max

mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
render_frameskip=1
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$GOGROOT/Under a Killing Moon/UAKM.gog" -t iso
_EOFAE_

# Select SoundBlaster MIDI by default
if type -t POL_unbase64 > /dev/null; then
    POL_unbase64 <<-_EOF_ > "$GOGROOT/Under a Killing Moon/CONFIG.INI"
	W0RJR0lfQ09ORklHXQ0KQm9hcmROdW09Mw0KSW9BZGRyPTB4MjIwDQpETUE9NQ0KSW50PTUNClZv
	bHVtZT0xMDANCg0KW01JRElfQ09ORklHXQ0KQm9hcmROdW09Mg0KSW9BZGRyPTB4Mzg4DQpEaWdp
	RHJ1bXM9WWVzDQpWb2x1bWU9MTAwDQoNCltTWVNURU1dDQpMYXN0UGxheWVyPUVBU1kNClBhc3M9
	MQ0KQ2hhaW5JbnQ4PVllcw0KQ2hhaW5JbnQxQz1ZZXMNCg0KW1BSRUZdDQpIaW50cz1Pbg0KQ2Fw
	dGlvbmluZz1Pbg0KV2Fsa2luZ1NwZWVkPUZhc3QNCk1vdXNlU2Vucz1NZWQNClRpbHRDbnRybD1O
	b3JtDQpXaW5kb3dTaXplPTcNClJlbmRlcmluZz1IaWdoDQpBdXRvNDMyeDMyND1PZmYNCkN5YmVy
	TW91c2U9T2ZmDQpNUEVHPU9mZg0KRm9yY2VTY2FsaW5nPU9mZg0KDQpbVklERU9dDQpUcmFuc2Zl
	clJhdGU9MjA5OTE4DQpEaXJlY3REcml2ZT0wDQpWR0FMZXR0ZXJCb3g9T2ZmDQpCcmlnaHRuZXNz
	PTANCg0KW0RFQlVHXQ0KTG9nZmlsZT1kZWJ1Zy5sb2cNCk1vbm89T2ZmDQpEaXNwbGF5PU9mZg0K
	UHJpbnRlcj1PZmYNClNlY3Rpb25GbGFnPU9mZg0KDQpbQ0RfTUFQXQ0KRGlzazE9RA0KRGlzazI9
	RA0KRGlzazM9RA0KRGlzazQ9RA0KDQo=
	_EOF_
fi

POL_Shortcut "TEX197.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Under a Killing Moon/manual.pdf"
# C:\GOG Games\Under a Killing Moon\readme.txt
# C:\GOG Games\Under a Killing Moon\Solution.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlN5K4IACgkQ5TH6yaoTykejOgCgmdgLHEnkOOiZvP6aEUnon9Mv
lXUAn0SJ6f82jw3RvypCfCtxUiCcwS4W
=UWHG
-----END PGP SIGNATURE-----
