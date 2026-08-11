#!/bin/bash
# Date : (2011-12-18 11-39)
# Last revision : see changelog
# Wine version used : 1.3.36, 1.4.1, 1.6.2
# Distribution used to test : Kubuntu 18.04 amd64
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-18 11-39)
#   Initial script (Wine 1.3.36).
#   1.3.35 has a problem with Direct3D9 renderer water effects.  Seems to be fixed in 1.3.36 :) 
# [Pierre Etchemaite] (2014-04-01 19-02)
#   Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-03-20 19:30). Script tested with GOG v2.0.0.9.
#   Wine 1.6.2 -> 3.0.3
# [Dadu042] (2020-04-09 18:30). Script tested with GOG v2.1.0.12.
#   Remove '/nogui' at 'POL_Call POL_GoG_install' because this crash the GOG installer v2.x
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
GOGID="far_cry"
PREFIX="FarCry_gog"
WORKING_WINE_VERSION="3.0.3"
  
TITLE="GOG.com - Far Cry"
SHORTCUT_NAME="Far Cry"
SHORTCUT_EDITOR="$SHORTCUT_NAME - CryEngine Sandbox"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
  
POL_SetupWindow_Init
POL_SetupWindow_SetID 1024
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Crytek Studios / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"
  
POL_Call POL_GoG_setup "$GOGID" "e26869ba3755084f7b51be5174479d01" "980dbc3d41af088b46d6b3dfa1c1dc3d" "d7cbea9fa8afb4de00f30beeca9d11fa"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_GoG_install
  
  
cd "$GOGROOT/Far Cry/"
if [ $? -eq 0 ]; then
    # Disable new external configurator, as it generates setups that are
    # not compatible with Wine...
    mv "Bin32/FarCryConfigurator.exe" "Bin32/FarCryConfigurator.exe.disabled"
else
  POL_Debug_Error "$(eval_gettext 'Could not find program directory')"
fi
  
# GoG work!
Set_OS winxp
  
POL_SetupWindow_VMS "64"
  
# Doesn't hurt ;)
POL_Wine_reboot
  
LNG_EDITOR="$(eval_gettext 'The level editor')"
POL_SetupWindow_checkbox_list "$(eval_gettext 'What extra shortcuts should be created?')" "$TITLE" "${LNG_EDITOR}" "~"
SHORTCUTS="$APP_ANSWER"
  
POL_Shortcut "FarCry.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Far Cry/Manual.pdf"
# C:/GOG Games/Far Cry/Readme.txt
# C:/GOG Games/Far Cry/Manual_1_4.pdf
  
if echo "$SHORTCUTS" | grep -q "$LNG_EDITOR"; then
    POL_Shortcut "Editor.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_EDITOR.png" "" "Game;ActionGame;"
    POL_Shortcut_Document "$SHORTCUT_EDITOR" "$GOGROOT/Far Cry/Editor Manual.pdf"
fi
  
# C:/GOG Games/Far Cry/Dedicated server guide.rtf
# C:/GOG Games/Far Cry/Using the FarCry dedicated server.rtf
# C:/GOG Games/Far Cry/Server_Command_Table.pdf
  
POL_SetupWindow_message "$(eval_gettext 'Default video settings are a bit low for modern computers,\nremember to click on "Auto-detect" in advanced video settings.')" "$TITLE"
  
POL_SetupWindow_Close
  
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""
  
POL_LoadVar_PROGRAMFILES
  
cd "$GOGROOT/Far Cry/" || exit 1
  
TITLE="$TITLE"
  
POL_SetupWindow_Init
  
[ -f system.cfg ] || POL_Debug_Fatal "\$(eval_gettext 'Run the game once to create the configuration file!')"
  
DRIVER="\$(sed -e 's/^r_Driver = \"\(.*\)\".*/\1/p; d' system.cfg)"
VERBOSITY="\$(sed -e 's/^log_Verbosity = \"\(.*\)\".*/\1/p; d' system.cfg)"
  
POL_SetupWindow_menu_list "\$(eval_gettext 'Pick video driver to use [experimental]:')" "\$TITLE" "Direct3D9~OpenGL" "~" "\$DRIVER"
NEW_DRIVER="\$APP_ANSWER"
  
POL_SetupWindow_menu_list "\$(eval_gettext 'Verbosity while loading maps:')" "\$TITLE" "0~1~2~3~4~5~6~7~8" "~" "\$VERBOSITY"
NEW_VERBOSITY="\$APP_ANSWER"
  
if [ "\$NEW_DRIVER" != "\$DRIVER" -o "\$NEW_VERBOSITY" != "\$VERBOSITY" ]; then
    sed -i.bak -e 's/^r_Driver = ".*"/r_Driver = "'"\$NEW_DRIVER"'"/' \
               -e 's/^log_Verbosity = ".*"/log_Verbosity = "'"\$NEW_VERBOSITY"'"/' \
      system.cfg
fi
  
POL_SetupWindow_Close
exit 0
_EOF_
  
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo9QdwAKCRDlMfrJqhPK
Rxi6AKCeZK/L4OYmsRZ0YRSx36l/fIrmyACdGXwDopnW4Ock36m6Bj/dcD5Kk+Q=
=zDEK
-----END PGP SIGNATURE-----
