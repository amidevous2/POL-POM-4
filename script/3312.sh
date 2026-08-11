#!/bin/bash
# PlayOnLinux Function
# Date : (2018-02-11 21-43)
# Last revision : (2018-02-11 21-43)
# Author : lahtis

# Setting default path for installers
POL_LoadVar_PROGRAMFILES
 
# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Call POL_Function_FontsSmoothRGB
 
# Fix to prevent Steam from launching without text after update
POL_Wine_OverrideDLL "" "dwrite"
 
# Installing Steam
POL_Download_Resource "http://nuts.itch.zone/download/windows"
mv "windows" "itchSetup.exe" 
cd "$POL_USER_ROOT/ressources/"
POL_SetupWindow_wait "$(eval_gettext 'Please complete the Itch.io setup wizard.')" "$(eval_gettext '$TITLE - Itch.io Installation')"
POL_Wine "itchSetup.exe"
POL_SetupWindow_message "$(eval_gettext 'Log into your Itch.io account once the update is complete.\n\nClick Next to continue.')" "$TITLE - Itch.io Update and Login"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNUz8wAKCRDlMfrJqhPK
RynHAKChSpCG4AqQtIgpx6sNpILza/oUFgCfedC36ltSbRK/sWslz6HUL0Wq2zE=
=62Mr
-----END PGP SIGNATURE-----
