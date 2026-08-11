#!/bin/bash
# Date : (2012-12-08 09-28)
# Last revision : (2013-11-24 19-30)
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Dadu042] (2020-01-02)
#   First script (Wine 4.0.3).
# [Dadu042] (2020-01-02)
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="hitman"
PREFIX="HitmanCN47_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Hitman: Codename 47"
SHORTCUT_NAME="Hitman: Codename 47"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1506
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "IO Interactive / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6a1f8e9507639f39e6ff737ab7f7ce79"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Select OpenGL renderer by default
cat <<'_EOFCFG_' | perl -pe 's/\n/\r\n/' > "$GOGROOT/Hitman Codename 47/Hitman.ini"
Include Setup\Locale.zip
//DrawDll Render3DFX.dll
DrawDll renderopengl.dll
//DrawDll RenderOpenGL.dll
SoundDll Sound.dll
ScriptDll GSC.dll
LocaleDLL Locale.dll
Resolution 800x600
ColorDepth 0
_EOFCFG_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "hitman.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Hitman Codename 47/manual.pdf"
# C:\GOG Games\Hitman Codename 47\keybindings_Numpad.pdf
# C:\GOG Games\Hitman Codename 47\keybindings_WASD.pdf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Hitman Codename 47/" || exit 1
TITLE="$TITLE"

POL_Wine Setup.exe
if grep -qi '^DrawDll Render3DFX\.dll' "$GOGROOT/Hitman Codename 47/"[Hh]itman.ini; then
    POL_Wine nglide_config.exe
fi

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg57iQAKCRDlMfrJqhPK
R2SiAJwP5S1wzIp5grXyQD2Zy5ssAYzvcQCbBRQxmT3lf85AYd6VKVTE3zquxSo=
=ktaa
-----END PGP SIGNATURE-----
