#!/bin/bash
# Date : (2016-09-04)
# Distribution used to test : Xubuntu 20.04 64bits
# Author : YukkuriLord (Sparkylinux 4.3 32 bit pae)
 
# Tests reports: https://appdb.winehq.org/objectManager.php?sClass=application&iId=16223


# TESTED Editions (version at the bottom of the login window): 0.377.0 / Settings -> About: '2.1.13. 0.377.0'.
 
# Middlewares used by this software : Visual C++ 2015 (as of 2019).
 
# CHANGELOG:
# [YukkuriLord] (2016-09-04)
#   Initial writting.
# [Dadu042] (2019-12-09)
#   Localized download links don't work anymore (impossible to refind these), I remake it simple.
#   Wine 1.9.18 -> 4.21.
# [Dadu042] (2020-10-29 12-00). Client: '2.1.13. 0.377.0'
#   Wine 4.21 -> 4.21-staging
#   Disable: POL_Install_gecko (outdated) POL_Install_wininet (should be useless).

# KNOWN ISSUES:
#  Wine x86 4.0.3, 4.0.4, 5.0.2: SparkWebHelper.exe has multiple crashes. Fix: Wine 4.21-staging
#  Wine x86 4.0.3, 4.21: Texts are not displayed in the windows. Fix: Wine 4.21-staging
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
PREFIX="Gameforge"
WINEVERSION="4.21-staging"
TITLE="Gameforge Live"
EDITOR="Gameforge 4D GmbH"
GAME_URL="https://gameforge.com/"
AUTHOR="YukkuriLord"
   
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2599
   
POL_Debug_Init
   
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
############################################
#  Choose architecture: 32 bits or 64 bits #
############################################

# POL_SetupWindow_menu "$(eval_gettext 'What architecture do you want to use ?')" "$TITLE" "$(eval_gettext '64 bits (recommended)')~$(eval_gettext '32 bits')" "~"
# if [ "$APP_ANSWER" == "32 bits" ]; then
#	POL_System_SetArch "x86"
# elif [ "$APP_ANSWER" == "$(eval_gettext '64 bits (recommended)')" ]; then
#	POL_System_SetArch "amd64"
# fi

POL_System_SetArch "x86"

############################################
#  Create Wine prefix                      #
############################################

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_System_TmpCreate "$PREFIX"
 
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
 
cd "$POL_System_TmpDir"
    
# Configuration
Set_OS "win7"

# (2016, Wine 1.9.18)   https://fr.wikipedia.org/wiki/Multipurpose_Internet_Mail_Extensions
POL_Wine_OverrideDLL "native,builtin" "mailmime"
   
# Dependencies
POL_Call POL_Install_corefonts
 
# POL_Call POL_Install_wininet
# POL_Call POL_Install_gecko
   
# Installation
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Do not close $TITLE until the installation is complete.')" "$TITLE"
 
cd "$HOME"
POL_Wine "$SETUP_EXE" # "/SILENT"
POL_Wine_WaitExit "$TITLE" --allow-kill
   
POL_SetupWindow_VMS "64"
POL_Wine_reboot
   
# Create Shortcut
POL_Shortcut "Gameforge live.exe" "$TITLE" "" "" "Game;"
   
# Cleanup
POL_System_TmpDelete
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX5qlaQAKCRDlMfrJqhPK
RybgAJ417GlC1T03mz71VS3h4Ep6RaZVjwCggeGURmc9GNm5oFL28ghdKOsK+rE=
=cJek
-----END PGP SIGNATURE-----
