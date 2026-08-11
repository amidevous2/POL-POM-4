#!/bin/bash
# PlayOnLinux Function
# Date : (2012-03-04 21:00)
# Last revision : (2017-11-22 23:52)
# Author : GNU_Raziel (original script), LinuxScripter (changing the link to the latest one, it's not UbisoftGameLauncher anymore)
# Only For : http://www.playonlinux.com

# Downloading Uplay - No md5 check since this kind of software is updated very often
# Since we cannot validate the file with a hash (changes too often), do not put it into resources
# Otherwise in case of corrupted download, the only solution for the user is to clean his cache
# Download is not that large anyway (~70MB)
cd "$POL_USER_ROOT/tmp/"
POL_SetupWindow_download "$(eval_gettext 'Please wait while $APPLICATION_TITLE is downloading Ubisoft Game Launcher')" "$TITLE" "https://ubistatic3-a.akamaihd.net/orbit/launcher_installer/UplayInstaller.exe"

# Installing mandatory dependencies
POL_Call POL_Install_vcrun2008

# Installing Ubisoft Game Launcher
cd "$POL_USER_ROOT/tmp/"
POL_Wine "UplayInstaller.exe" /q
POL_Wine_WaitExit "UplayInstaller.exe"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg2aVQAKCRDlMfrJqhPK
R1UnAJ9hOB08lUJBb4bN9i/6zIuV6QQUJACfeZLzLwC0XiMG+xeo8iB14CHz0L4=
=HBAo
-----END PGP SIGNATURE-----
