#!/bin/bash
# Date : (2013-08-22 23-00)
# Last revision : (2013-11-16 06-22)
# Wine version used : 1.4.1, 1.6.1
# Distribution used to test : Fedora 19
# Author : TonyFlow
#  Updated: petch
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [TonyFlow] (2013-08-22 23-00)
#   Initial script.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.6.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tropico_3_gold_edition"
PREFIX="Tropico3GE_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Tropico 3 Gold Edition"
SHORTCUT_NAME="Tropico 3 - Gold Edition"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1805
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Kalypso / Haemimont Games" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "dade4fc6054170479c4bcc4b3b88adda" "e28751a0a9ee8c81de2c6918b4f28136" "58d6c369c0e15c39a830f8747da3e0e9" "0fc2cbeda6f06fc0d483e91922f95f94"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"

# GoG work!
Set_OS winxp

POL_Call POL_Install_d3dx9_36

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot


GOGPATH="$GOGROOT/Tropico 3 GOLD"

# Tropico 3 was preset in full screen mode with a resolution that can be too high...
# Furthermore full screen mode can only be enabled or disabled in the config file...
# And unfortunately default config file is encrypted, so overwrite it with a clear one !
# http://forum.kalypsomedia.com/showthread.php?tid=4484&pid=149693#pid149693
mv "$GOGPATH/config.lua" "$GOGPATH/config_orig.lua"
cat <<_EOF_ > "$GOGPATH/config.lua"
config.IsFullscreen = 0
config.RunUnfocused = 0

config.WriteToRegistry = 1
config.AutoOptions = 1
config.ColorBits = 32
config.DepthBits = 24
config.VSync = 0
config.RefRast = 0
config.MeshVertexBufferChunkSizeKb = 1280
config.MeshIndexBufferChunkSizeKb = 512
config.MapSlotReserveSize = 12

config.SoundListenerMinUpdatePeriod = 50
config.FmodMemory = 10485760

config.XInput = 0

config.MaxGameObjectCount = 200000
config.MaxGameObjectExCount = 10000
config.MaxGameRenderObjCount = 20000

config.MainMenu = 1

hr.UpdateLights = 0
_EOF_

POL_Shortcut "tropico3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Manual.pdf"
POL_Config_PrefixWrite "LANGUAGE" "English"

POL_SetupWindow_Close

# Configurator script (full screen mode ; language selection)
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

TITLE="$TITLE"
SHORTCUT_NAME="$SHORTCUT_NAME"
GOGPATH="$GOGPATH"
cd "\$GOGPATH" || exit 1

POL_SetupWindow_Init

# Language selection
CURRENT="\$(POL_Config_PrefixRead "LANGUAGE")"
OTHERS="\$(sed -e "s/~\$CURRENT//" <<< "~English~French~German~Italian~Spanish")"
POL_SetupWindow_menu "\$(eval_gettext 'Choose the game language you want')" "\$TITLE" "\${CURRENT}\${OTHERS}" "~"
POL_Config_PrefixWrite "LANGUAGE" "\$APP_ANSWER"

cat <<_EOFINI_ > "\$POL_USER_ROOT/tmp/t3lang.reg"
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Haemimont Games\Tropico3]
"Language"="\$APP_ANSWER"
_EOFINI_
POL_Wine regedit "\$POL_USER_ROOT/tmp/t3lang.reg"
rm "\$POL_USER_ROOT/tmp/t3lang.reg"

# Configure the shortcut
MANUAL="Manual.pdf"
[ "\$APP_ANSWER" = "French" ] && MANUAL="manual_fr.pdf"
[ "\$APP_ANSWER" = "German" ] && MANUAL="manual_de.pdf"
[ "\$APP_ANSWER" = "Italian" ] && MANUAL="manual_it.pdf"
[ "\$APP_ANSWER" = "Spanish" ] && MANUAL="manual_sp.pdf"
POL_Shortcut_Document "\$SHORTCUT_NAME" "\$GOGPATH/\$MANUAL"

# Ask for full screen mode
POL_SetupWindow_question "\$(eval_gettext 'Run game full screen?')" "\$TITLE"
FULLSCREEN=0
[ "\$APP_ANSWER" = "TRUE" ] && FULLSCREEN=1
sed -i .old -e 's/^config.IsFullscreen =.*$/config.IsFullscreen = '\$FULLSCREEN'/' config.lua

POL_SetupWindow_Close

exit 0
_EOF_

# Run the configurator?
bash "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxIkQAKCRDlMfrJqhPK
R45zAJ9nsCahgNjWNIWTRhmtrAKG6QwCzQCdFRgxPFTen8QcxDJTE351XqJWEog=
=wa7K
-----END PGP SIGNATURE-----
