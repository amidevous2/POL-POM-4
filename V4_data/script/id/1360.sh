#!/bin/bash
 
# CHANGELOG
# [Quentin P] (2014 ?)
#   Initial writting.
# [Dadu042] (2019-11-15 12-55)
#   Wine "1.5.10-battlefront" -> 2.22
# [Dadu042] (2019-11-15 13:23)
#   Add install from local
# [Dadu042] (2019-11-16 22:20)
#   Wine 2.22 -> 3.0.3. I tested with GOG.com release v1.1
# [Dadu042] (2019-11-17 15:35)
#   Force winxp and x86
#   Fix a log issue.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Star Wars - Battlefront II (2005)"
PREFIX="StarWarsBattlefrontII2005"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "LucasArts" "" "Tinou" "$PREFIX"
 
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
POL_System_SetArch "x86"
Set_OS "winxp"

################
#      GPU     #
################
  
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

################

# Fix for 'err:ole:CoGetClassObject class {ef985e71-d5c7-42d4-ba4d-2d073e2e96f4} not registered'
POL_Call POL_Install_mdac28

POL_SetupWindow_InstallMethod "DVD,LOCAL"
 
if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Gamedata/Setup.exe"
        cd "$CDROM"
        POL_Wine --ignore-errors "$CDROM/Gamedata/Setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then        
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
fi
 
POL_Shortcut "LaunchBFII.exe" "$TITLE" "" "" "Game;ActionGame;"
POL_Shortcut_QuietDebug "$TITLE"

# In the GOG release, filename is this one:
POL_Shortcut "BattlefrontII.exe" "$TITLE" "" "" "Game;ActionGame;"
POL_Shortcut_QuietDebug "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdFbLAAKCRDlMfrJqhPK
RxDnAJ92dBJ9YVE++Q1YtIhyd3HbCZXCqQCeIMv0qGX4DR5eMCYhFaTRo5i87os=
=2MUZ
-----END PGP SIGNATURE-----
