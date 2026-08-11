#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-14 21:00)
# Last revision : (2013-04-22 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

FORCE_MODE=$1

# Downloading Mono 2.10
mkdir -p "$POL_USER_ROOT"/ressources/mono210/
cd "$POL_USER_ROOT"/ressources/mono210/
POL_Download_Resource "http://download.mono-project.com/archive/2.10.9/windows-installer/0/mono-2.10.9-gtksharp-2.12.11-win32-0.exe" "af8e1a36fbed6bd84b245dd603b365bb" "mono210"

# Check if mono210 is already installed
CHECK_MONO210=`find $WINEPREFIX -name "mono-2.0.dll"`
if [ "$CHECK_MONO210" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
	POL_Wine start /unix "mono-2.10.9-gtksharp-2.12.11-win32-0.exe" /silent
	POL_Wine_WaitExit "Mono 2.10"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1upwACgkQ5TH6yaoTykemQwCfY1OJ+9fsRoo2LgEkkqsuNPxf
HiwAoIdjwc0ld9sZlvvZWiS/+kiDlqzl
=/Bq0
-----END PGP SIGNATURE-----
