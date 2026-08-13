#!/bin/bash
# Date : (2011-17-07 21-00)
# Last revision : (2011-09-11 18:03)
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Witcher 2 : Assassins of Kings"
PREFIX="witcher2"
PVERSION="Enhanced Edition"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/witcher2/top.jpg" "http://files.playonlinux.com/resources/setups/witcher2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the $PVERSION installer for $TITLE')"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

# Asking if patch is local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
else
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://wpc.4d7d.edgecastcdn.net/004D7D/files/Downloader_EE/Downloader.exe"
	POL_Wine start /unix "Downloader.exe"
	POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+jz4EACgkQ5TH6yaoTykcgCgCgoqaCzj/ijbr2IggHJkL9Sokb
c40An38DXHnHbpkyFDHplyTVk+h1kYj1
=Zx/T
-----END PGP SIGNATURE-----
