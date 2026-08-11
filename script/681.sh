#!/bin/bash
# Date : Unkown
# Last revision : (2013-05-19 12-16)
# Author : unknown
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-19 12-16)
#   gettext

MODE=$1
DLL=$2
if [ "$mode" = "disabled" ]
then
        unset mode
fi

cat << EOF > "$POL_USER_ROOT/tmp/override-dll.reg"
REGEDIT4

[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]
EOF

until [ "$DLL" == "" ]; do
        echo "\"*$DLL\"=\"$MODE\"" >> "$POL_USER_ROOT/tmp/override-dll.reg"
        shift
        DLL="$2"
done

POL_SetupWindow_wait_next_signal "$(eval_gettext 'Please wait...')" "$TITLE"
POL_Wine regedit "$POL_USER_ROOT/tmp/override-dll.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGYp7MACgkQ5TH6yaoTykfISQCffmrYoEosda9Uu4hM8k5YSGg8
4R0AnjcsRaXPJ2qNSvckyGgLx3YjnXrr
=kylz
-----END PGP SIGNATURE-----
