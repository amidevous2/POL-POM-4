#!/bin/bash
# Date : (2010 ?)
# Last revision : see changelog
# Author : Quentin Paris
# Only For : http://www.playonlinux.com

#
# CHANGELOG
# [Quentin Paris] (2011 ?)
#   Initial script.
# [Dadu042] (2020-08-29 10-00)
#   Add #!/bin/bash and infos
#

POL_Download "http://download.microsoft.com/download/5/5/8/55846E20-4A46-4EF8-B272-7F988BC9090A/gfwlivesetupmin.exe" "c0d501ef65af23efa0b2414e9b85ff66"
 
POL_Wait "$(eval_gettext "Installing Games For Windows Live")" "$TITLE"
POL_Wine gfwlivesetupmin.exe /nodotnet

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX0pWnQAKCRDlMfrJqhPK
R7BoAJ98aJeUewFICiUiRhLrn5TZerwvJACgktyjl7polmwFNdo8mWiKXJx7kUg=
=9qtA
-----END PGP SIGNATURE-----
