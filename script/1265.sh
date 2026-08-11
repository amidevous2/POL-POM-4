#!/bin/bash
# Date : (2012-06-20 16-56)
# Last revision : (see changelog)
# Distribution used to test : Ubuntu 18.04
# Author: Fekir (first script)
# Wine version used: 2.22
  
# CHANGELOG
# [Fekir] (2019)
#   First script.
# [SuperPlumus] (2013-05-14 20-22)
#   Clean code
# [mstern.pds] (2014)
#   Wine 1.4 -> 1.6.2 (fix for Linux Mint 17). Edited wine version and downloaded installer.
# [petch] (2015)
#   Update download hash
# [Ronin Dusette] (2015-06)
#   Updating to newer Wine version, as 1.7.39 has a platium rating for this app on appdb.winehq.org
#   Apparently Core Fonts needs to be explicitly installed to stop the crash. Not sure why.
# [Dadu042] (2019-07-17 17:30)
#   Changelog updated.
#   Add warning about the (old) version the script can download.
# [Dadu042] (2019-07-17 18:00)
#   Wine 1.7.39 -> 2.22
#   Kindle 1.11 (2009) -> 1.17 (2017) according this report: https://www.playonlinux.com/en/topic-16611-Kindle_for_PC.html
# [Dadu042] (2020-10-06 16:00)
#   Wine 2.22 (outdated) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Amazon Kindle"
PREFIX="amazon-kindle"
WORKING_WINE_VERSION="3.0.3"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE for PC" "Amazon" "http://www.amazon.com" "Fekir" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_Install_corefonts
  
POL_System_TmpCreate "$PREFIX"
  
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine start /unix "$APP_ANSWER"
        rm "$WINEPREFIX/drive_c/windows/winsxs/manifests/x86_microsoft.vc90.crt_1fc8b3b9a1e18e3b_9.0.30729.4148_none_deadbeef.manifest"
        POL_Wine_WaitExit "$TITLE"
  
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        POL_SetupWindow_message "Warning: this script will download Kindle v1.17 (2017)\n\n 'Kindle for PC 1.17 was the last version that kept all the books in one MASS folder before splitting each book into it's own folder.  It's also the last version before they changed the azw format slightly so that Calibre no longer recognized it'\n(ref: https://www.amazonforum.com/forums/devices/kindle-e-readers/473842-solved-where-can-i-download-older-versions-of-the )."
 
        cd "$POL_System_TmpDir"
        POL_Download "https://web.archive.org/web/20170111115226/https://s3.amazonaws.com/kindleforpc/44183/KindleForPC-installer-1.17.44183.exe" "4af89dcb9c6a6323ecd792d8dcf57330"
        mv KindleForPC-installer-1.17.44183.exe KindleForPC-installer.exe
 
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine start /unix "KindleForPC-installer.exe"
 
        rm "$WINEPREFIX/drive_c/windows/winsxs/manifests/x86_microsoft.vc90.crt_1fc8b3b9a1e18e3b_9.0.30729.4148_none_deadbeef.manifest"
 
        POL_Wine_WaitExit "$TITLE"
fi
  
POL_System_TmpDelete
POL_Shortcut "Kindle.exe" "$TITLE"
POL_Wine_reboot
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX3xvygAKCRDlMfrJqhPK
R8V3AJ9/hyZrpV9jORHrhT8olDtpNTgfWgCfcxcpAlOV0vXEvPR5pacpsZDUjKk=
=oDGz
-----END PGP SIGNATURE-----
