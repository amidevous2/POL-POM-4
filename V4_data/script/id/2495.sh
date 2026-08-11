#!/bin/bash
# Date : (2015-04-06 13-43)
# Last revision : (2015-04-06 13-43)
# Wine version used : 1.6.2
# Distribution used to test : Ubuntu 14.04 LTS
# Author : João Brázio <joao@brazio.org>
# URL : https://github.com/jbrazio/miscellaneous/tree/master/pol/ltspice
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "${PLAYONLINUX}/lib/sources"
 
TITLE="LT Spice IV"
PREFIX="LTSpiceIV"
INSTALLER_DOWNLOAD="http://ltspice.linear-tech.com/software/LTspiceIV.exe"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "${TITLE}" "Linear Technology" "http://www.linear.com/designtools/software/" "João Brázio <joao@brazio.org>" "${PREFIX}"
 
POL_Wine_SelectPrefix "${PREFIX}"
if [ "$(POL_Wine_PrefixExists "${PREFIX}")" = "False" ]; then
    POL_Wine_PrefixCreate
fi
 
Set_OS "win7"
POL_System_SetArch "x86"
 
POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB
 
POL_System_TmpCreate "${PREFIX}"
cd "${POL_System_TmpDir}"
 
POL_Download "${INSTALLER_DOWNLOAD}"
POL_SetupWindow_wait "$(eval_gettext 'IInstallation in progress.')" "$TITLE"
POL_Wine start /unix "${POL_System_TmpDir}/LTspiceIV.exe"
POL_Wine_WaitExit "${TITLE}"
 
POL_Shortcut "scad3.exe" "$TITLE" "" "" "Development;Engineering;Electronics;"
POL_Extension_Write asc "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'Installation finished.')" "$TITLE"
 
[ -d "${POL_System_TmpDir}" ] && POL_System_TmpDelete
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg597wAKCRDlMfrJqhPK
R6yTAJ98olar6mq5SGi6FZd6dqqNQycuMQCfUj8aj+tainaTa/phPkDZHiE+bD0=
=sMmq
-----END PGP SIGNATURE-----
