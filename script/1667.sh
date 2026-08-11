#!/bin/bash
# Date : (2013-04-22 21:00)
# Last revision : N/A
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Fix the black-screen issue for Diablo III (and probably other games) with ATI/AMD GPU FGLRX driver
POL_Wine_DetectCard
if [ "$DRVID" = "ATI" ]; then
	POL_Wine_Direct3D "AlwaysOffscreen" "enabled"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1Z1cACgkQ5TH6yaoTykfKEQCeLno/HesX8DFRJkl5MXLAhS6q
hREAn0hKHwZGniURiubqUYAQcYWQUVf7
=3L+D
-----END PGP SIGNATURE-----
