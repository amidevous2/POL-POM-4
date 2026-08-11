#!/bin/bash
# PlayOnLinux Function
# Date : (2011-17-07 21-00)
# Last revision : (2013-01-22 21:34)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Setting default path for installers
POL_LoadVar_PROGRAMFILES

# Downloading latest Desura
cd "$POL_USER_ROOT/tmp"
# Since we cannot validate the file with a hash (changes too often), do not put it into resources
# Otherwise in case of corrupted download, the only solution for the user is to clean his cache
# Download is not that large anyway (~1.2MB)
POL_SetupWindow_download "$(eval_gettext 'Please wait while Desura is downloaded...')" "$TITLE" "http://www.desura.com/DesuraInstaller.exe"

# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB

# Installing Desura
cd "$POL_USER_ROOT/tmp"
POL_Wine start /unix "DesuraInstaller.exe" /q /s
POL_Wine_WaitExit "Desura"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlD++REACgkQ5TH6yaoTykeHdwCdEaUE2muaOHIiVXFy0j0uL91Y
hpsAoKO1NyVhkli9cAqpxs0l9p6VHSis
=98K/
-----END PGP SIGNATURE-----
