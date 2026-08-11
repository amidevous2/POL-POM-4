#!/bin/bash
# PlayOnLinux Function

# Date : (2009-11-21)
# Last Revision : (2013-01-22 19:53)
# Author : Berillions
# Licence : 
# Depend : none

# [petch] (2013-01-22 19:53)
#   Fixing bug #1787
# [Dadu042] (2020-06-13 11:10)
#   Improve the warning message.

# Until fixed
if [ "$POL_ARCH" = "amd64" ]
then
    POL_Debug_Error "AMD64 is set, msxml6 can not be installed."
else
    cd "$REPERTOIRE/ressources"
    POL_Download_Resource "https://web.archive.org/web/20190122095451if_/http://download.microsoft.com/download/e/a/f/eafb8ee7-667d-4e30-bb39-4694b5b3006f/msxml6_x86.msi" "85a5571258de322458f288b94ee28cfb"

    POL_Wine_OverrideDLL "native" "msxml6"
    rm "$WINEPREFIX"/drive_c/windows/system32/msxml6*
    POL_Wine_WaitBefore "msxml6"
    POL_Wine msiexec /i msxml6_x86.msi /q

    POL_SetupWindow_detect_exit
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYDEkrgAKCRDlMfrJqhPK
R0yIAJ40cWT+IDUVj4AAp90gDgHyxGTA8QCgmjtgJr3/1CpIizrYvGeZXqX0IGI=
=Wbcl
-----END PGP SIGNATURE-----
