#!/bin/bash
# PlayOnLinux Function
 
# Date : (2009-11-21)
# Last revision : (2013-01-22 23:09)
# Author : Berillions
# Licence : 
# Depend : none

#downloading msxml4
POL_Download_Resource "http://web.archive.org/web/20120322033534if_/http://download.microsoft.com/download/A/2/D/A2D8587D-0027-4217-9DAD-38AFDB0A177E/msxml.msi" "14e34a6cbd8f060a9c965e39b745657a"

POL_SetupWindow_wait_next_signal "PlayOnLinux is installing msxml4" "$TITLE"

cd "$REPERTOIRE/ressources"
POL_Wine_OverrideDLL "native" "msxml4"
POL_Wine msiexec /i msxml.msi /q

POL_SetupWindow_detect_exit
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYiUeWwAKCRDlMfrJqhPK
R0z9AJ9/9W5k3DoeyRnC7sfFuP3XMWhsbwCghKar7kJIJZwSABseGy9sCGmHkBM=
=ViDw
-----END PGP SIGNATURE-----
