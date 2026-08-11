#!/bin/bash
# Date : (2014-08-20 22:00)
# Last revision : (2014-08-20 22:00)
# Author : Tutul
# License : GNU/GPL v3
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Elder Scrolls 3 - AZERTY Patch"
TITLE_REQUIRED="The Elder Scrolls 3 - Morrowind"
PREFIX="TES3_Morrowind"

POL_SetupWindow_Init
#POL_SetupWindow_SetID 711
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the AZERTY patch Installer for $TITLE_REQUIRED')"
 
if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Patch reg
cat << EOF > TES3.reg
[HKEY_LOCAL_MACHINE\\Software\\Bethesda Softworks\\Morrowind]
"Auto Run"=dword:0x011f0000
"SlideLeft"=dword:0x01110000
"Forward"=dword:0x01120000
EOF
POL_Wine regedit TES3.reg
 
POL_SetupWindow_Close
exit 0


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQnKN0ACgkQ5TH6yaoTykdmlwCgqqjTN2hO3SHtr9/XyXuPzj3n
M/8An0D1BNE+UbNujD7X31QbK36eZtz3
=Hipv
-----END PGP SIGNATURE-----
