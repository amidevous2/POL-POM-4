#!/bin/bash


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="CAJViewer"
WINEVERSION="2.22"
TITLE="CAJViewer 7.2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 801

POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"

if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi
POL_Debug_Init
POL_System_SetArch "x86"

POL_SetupWindow_browse "$(eval_gettext 'Please select the file: CAJViewer 7.2.self.exe')" "$TITLE" 
SetupIs="$APP_ANSWER"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_msxml6
POL_Call POL_Install_msxml3

POL_Wine_OverrideDLL "native,builtin" "riched20" 
POL_Wine_OverrideDLL "native" "msxml3"
POL_Wine_OverrideDLL "native" "msxml6" 

POL_Wine_WaitBefore "$TITLE"

POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "CAJVieweru.exe" "CAJViewer 7.2" "" "" "Office;CAJViewer;"

POL_Extension_Write caj "CAJViewer 7.2"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb4K1AAKCRDlMfrJqhPK
R+3WAJ9rGieVW5EiOSvTZp2izfEW7861rQCeI4SLVsqQrvQJtyJ4TWXUGAIGOu4=
=YPFP
-----END PGP SIGNATURE-----
