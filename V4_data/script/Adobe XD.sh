#!/bin/bash
# Date : (2019-05-20)
# Distribution used to test : Arch Linux 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.8

# CHANGELOG
# [?] (201x ?)
#   First script.
# [Dadu042] (2019-12-18)
#   Wine 4.2 -> 4.0.3.
#   Standardize AdobeAir
#   Remove (because seems useless): vcrun2008, vcrun2005, msxml3
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
PREFIX="AdobeXD"
WINEVERSION="4.0.3"
TITLE="AdobeXD"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="RavenWroc"
         
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2316
         
POL_Debug_Init
         
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: this script does not work (2019-12), it need more work.')" "$TITLE"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies
POL_Call POL_Install_atmlib
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml6
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB
   
POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error saying that the installation failed, wait at least 5 minutes before closing it. PlayOnLinux will finish the install, even though it crashed.')" "$TITLE"
  
# Installation Adobe Air (2018)
# cd "$POL_System_TmpDir"
# POL_Download "http://s000.tinyupload.com/download.php?file_id=00627739392521952121&t=0062773939252195212168788"
# POL_Wine_WaitBefore "$TITLE"
# POL_Wine "$POL_System_TmpDir/XD_Set-Up.exe"
# POL_Wine_WaitExit "$TITLE"
# POL_System_TmpDelete
POL_Call POL_Install_AdobeAir

# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Adobe_XD.exe" "$TITLE" "" "" "Graphics"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfpFbQAKCRDlMfrJqhPK
R0oNAJ4xx0+HWcaNiil8D1LvZZRoJxsT/ACfXH0wvDBJK2z3/uILGVq4UiMcrQk=
=P9c/
-----END PGP SIGNATURE-----
