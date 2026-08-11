#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-14 21:00)
# Last revision : (2013-04-22 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

FORCE_MODE=$1

# Downloading Mono 2.8
mkdir -p "$POL_USER_ROOT"/ressources/mono28/
cd "$POL_USER_ROOT"/ressources/mono28/
POL_Download_Resource "http://download.mono-project.com/archive/2.8/windows-installer/9/mono-2.8-gtksharp-2.12.10-win32-9.exe" "c36436c1ba016b7cf25d8ec2480a2e03" "mono28"

# Check if mono28 is already installed
CHECK_MONO28=`find $WINEPREFIX -name "mono-2.0.dll"`
if [ "$CHECK_MONO28" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
	POL_Wine start /unix "mono-2.8-gtksharp-2.12.10-win32-9.exe" /silent
	POL_Wine_WaitExit "Mono 2.8"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1usoACgkQ5TH6yaoTykcG7wCgpkx9RbFhbF9hLdzG47F4dN56
SUEAoJl04/EeRDKqFMiYEnQDq6fnyEih
=8cSh
-----END PGP SIGNATURE-----
