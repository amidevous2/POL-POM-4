#!/usr/bin/env playonlinux-bash
# Date : (2019-06-23)
# Last revision : see changelog
# Wine version used : 3.20
# Distribution used to test : Debian 9
# Author : JR-Utily
# PlayOnLinux : 4.2.12
# Script licence : GPL3
# Program licence : Retail
    
# CHANGELOG
# [JR-Utily] (2019-06-23)
#   Initial writting.
# [Dadu042] (2019-12-30)
#   POL_RequiredVersion "4.0.0"
#   Fix shortcut category.
 
 

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Guitar Pro 7"
COMPANY="Arobas Music"
PREFIX="GuitarPro7"
WEBSITE="https://www.guitar-pro.com"
AUTHOR="JR-Utily"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$WEBSITE" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_question "$(eval_gettext 'Do you need to go to $COMPANY website to buy and/or download $TITLE official Windows installer ?')" "$TITLE"

if [ "$APP_ANSWER" = "TRUE" ]
then
POL_Browser "$WEBSITE"
fi

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

POL_SetupWindow_message "$(eval_gettext 'We will now install a new wine prefix.') $(eval_gettext 'Please say Yes when asking to install wine Mono and Gecko.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.20"
POL_Wine_InstallFonts

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.') $(eval_gettext 'Please say no when asked to execute $TITLE at the end of installation.')" "$TITLE"
POL_Wine "$INSTALLER"

POL_Call POL_Function_FontsSmoothRGB

POL_Shortcut "GuitarPro7.exe" "$TITLE" "" "" "AudioVideo;Music;"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgqXUQAKCRDlMfrJqhPK
R4WHAJ46mXEkdO0WuTpOEGbzKJ98yPB70QCfROe1MwpCsQGRwYuFniWvTux8M6c=
=64PS
-----END PGP SIGNATURE-----
