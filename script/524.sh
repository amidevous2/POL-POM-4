#!/bin/bash
# PlayOnLinux Function

cd "$WINEPREFIX/drive_c/windows/Fonts"

POL_Call POL_SP2_Extract tahoma.ttf
POL_Call POL_SP2_Extract tahomabd.ttf

chmod +w tahoma*.ttf


cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAipMcACgkQ5TH6yaoTykcwLACgoAAqBK1EjcO5nvR2NphTO0N3
sMMAnA/EQFgeM9e7ZlCmJXEY6B0UwWIK
=tT1f
-----END PGP SIGNATURE-----
