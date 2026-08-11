#!/bin/bash
# Date : Unkown
# Last revision : (2021-06-15 06:29)
# Author : unknown
# Updated by : GNU_Raziel & Yaotl
# Only For : http://www.playonlinux.com

# Downloading phyx
POL_Download_Resource "https://us.download.nvidia.com/Windows/9.19.0218/PhysX-9.19.0218-SystemSoftware.exe" "5114bf28a575264366c1ad0f5fe76fd0"

# Installing phyx
POL_Wine start /unix "PhysX-9.19.0218-SystemSoftware.exe" /s
POL_Wine_WaitExit "PhysX"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMibjAAKCRDlMfrJqhPK
R6hEAKCpnyFZOqHUfzpfv8OolMUVXV8owACfbyUCmsMHZjjuoXPfqVGvy5lzKV0=
=9EkG
-----END PGP SIGNATURE-----
