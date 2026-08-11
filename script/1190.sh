#!/bin/bash
# Date : (2012-05-14 00-51)
# Last revision : (2014-02-01 19-39)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="deus_ex"
PREFIX="DeusEx_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Deus Ex GOTY Edition"
SHORTCUT_NAME="Deus Ex"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1190
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ion Storm Inc. / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c515c61ef7aad49ac7ef804207787818"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$POL_USER_ROOT/tmp"
# Direct3D driver update
POL_Download "http://files.playonlinux.com/D3DDrv.dll" "8211caf827881d3969e1812fc6341146"
cp D3DDrv.dll "$GOGROOT/Deus Ex GOTY/System/D3DDrv.dll"

# Default OpenGL renderer crashes on exit, pick a better one
# Source http://www.cwdohnal.com/utglr/
POL_Download "http://files.playonlinux.com/dxglr21.zip" "e25ec9940eff8aa1e3a74e94ffdba706"
POL_System_ExtractSingleFile "dxglr21.zip" "OpenGLDrv.dll" "$GOGROOT/Deus Ex GOTY/System/OpenGlDrv.dll"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "DeusEx.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Deus Ex GOTY/manual.pdf"
# Game has issues with uncapped FPS (dialogs cut before the end...) => enable vblank
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "export __GL_SYNC_TO_VBLANK=1" # nvidia?
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "export vblank_mode=1"         # others?
# C:\GOG Games\Deus Ex GOTY\Help\ReadMe.htm
# C:\GOG Games\Deus Ex GOTY\Help\MPAdmin.htm
# C:\GOG Games\Deus Ex GOTY\Help\ReadMeMultiplayer.htm
# C:\GOG Games\Deus Ex GOTY\Help\MPMap.htm
# C:\GOG Games\Deus Ex GOTY\Help\ReadMeMPStrategy.htm
# C:\GOG Games\Deus Ex GOTY\Help\ReadMePatch1.htm
# C:\GOG Games\Deus Ex GOTY\Help\PatchFix.htm

# OpenGL tip
POL_SetupWindow_message "$(eval_gettext 'On first run the game will autodetect available renderers.\nIt is likely that you will get better performance out of the OpenGL renderer;\nYou can select it after clicking on "Show all devices".')" "$TITLE"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Deus Ex GOTY/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

POL_SetupWindow_question "$(eval_gettext 'Run $TITLE in safe mode?')" "\$TITLE"
[ "\$APP_ANSWER" = "TRUE" ] && POL_Wine System/DeusEx.exe -safe || POL_Wine System/nglide_config.exe

POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLtTmkACgkQ5TH6yaoTykd/nwCgpOEfTfDjdyGUzlGbxH+jBMzA
tkcAn0igA8FM8CaSY8Xqf0CUDly9FVcn
=0WkG
-----END PGP SIGNATURE-----
