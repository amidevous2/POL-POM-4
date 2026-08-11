#!/usr/bin/env playonlinux-bash
# Date : (2016-01-10 13-39)
# Last revision : (2016-01-10 13-39)
# Wine version used : 1.8
# Distribution used to test : Manjaro 2016-01-05
# Author : Brosnan Yuen
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Altium Designer 16"
 
PREFIX="AltiumDesigner16"
 
POL_SetupWindow_Init
 
POL_SetupWindow_message "$TITLE" "$(eval_gettext 'Download installer at') http://www.altium.com/"
 
POL_SetupWindow_browse "$(eval_gettext 'Setup location:')" "$(eval_gettext 'File selection')"
 
POL_Wine_SelectPrefix "$PREFIX"

POL_Wine_PrefixCreate "1.8"

Set_OS "win7"
 
POL_Call POL_Install_corefonts
 
POL_Call POL_Install_dotnet40
 
POL_Call POL_Install_mdac28
 
POL_SetupWindow_wait "$(eval_gettext 'Complete installer')" "$TITLE"
 
POL_Wine start /unix "$APP_ANSWER"

POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "DXP.exe" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPOGHQAKCRDlMfrJqhPK
R4BQAJ47QDCy+phIPtIALlcsc58KaSVEZACeJqW3ga5T/i6k7tDMj12KU7YlFio=
=wfaP
-----END PGP SIGNATURE-----
