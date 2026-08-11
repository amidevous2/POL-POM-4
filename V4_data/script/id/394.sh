#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init 
POL_SetupWindow_free_presentation "Anti-aliasing" "This script will enable anti-aliasing"
POL_SetupWindow_games "Choose an application" "Anti-aliasing"
if [ "$APP_ANSWER" == "" ]
then
POL_SetupWindow_Close
exit
fi
PREFIX=$(detect_wineprefix "$APP_ANSWER")
select_prefix "$PREFIX"
fonts_to_prefix
POL_SetupWindow_wait_next_signal "Processing" "Anti aliasing"
REGEDIT4


cat << EOF > "$REPERTOIRE/tmp/fontsaa.reg"
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingType"=dword:00000002
"FontSmoothingGamma"=dword:00000578
"FontSmoothingOrientation"=dword:00000001
EOF
regedit "$REPERTOIRE/tmp/fontsaa.reg"

POL_SetupWindow_detect_exit
POL_SetupWindow_message "Anti-aliasing has been successfully enabled" "Anti-aliasing"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYCYxFQAKCRDlMfrJqhPK
RwWcAJkB9VKptyeULxuUp2exD3M5IhRi/wCgnrHPebKhCJz5BHaJmyNc9maIJWo=
=E7/7
-----END PGP SIGNATURE-----
