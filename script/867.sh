#!/bin/bash
# Date : (2011-07-13 21-00)
# Last revision : (2013-12-02 21-09)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [Dadu042] (2013-12-02 21-09)
#   Update script (link broken, v23 -> v24 (2016))
#
# [VV] (2013-12-02 21-09)
#   Update script (link broken). 
#
# [SuperPlumus] (2012-05-18 06-31)
#   Update script (broken).

# Downloading Flashplayer for ActiveX (Internet Explorer Only)
cd "$POL_USER_ROOT/ressources"

POL_Download_Resource "https://fpdownload.macromedia.com/pub/flashplayer/installers/archive/fp_24.0.0.221_archive.zip" "900417642b4d1095af487a8cb03ef5ac"

POL_Wine_WaitBefore "Flash Player"

unzip -j fp_24.0.0.221_archive.zip $_0_r0_221/flashplayer24_0r0_221_winax.exe

POL_Wine "flashplayer24_0r0_221_winax.exe"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOlO+AAKCRDlMfrJqhPK
R3UiAJ9k5vZEOLLcEB22N0PDvnqclqQ89gCghKvQ/Xvy29bZUwUG0ZdxuIxM5zY=
=Ujez
-----END PGP SIGNATURE-----
