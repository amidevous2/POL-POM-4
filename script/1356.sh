#!/bin/bash

if [ "$1" ]; then 
	letter="$1"
else
	letter="w"
fi

[ "$CDROM" = "" ] && POL_Debug_Error "Please select a cdrom first"

DEVNODE="$(mount | grep "$CDROM" | awk '{print $1}')"

cd "$WINEPREFIX/dosdevices"

rm "$letter:" 2> /dev/null
rm "$letter::" 2> /dev/null

ln -s "$CDROM" "$letter:"
ln -s "$DEVNODE" "$letter::"


cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAlHfcACgkQ5TH6yaoTykeBVgCeNHAjR13aSZ3801ltTCEKRAjM
+6UAoIqV0n4ohxd+8xkqjGZvZFrqyzQV
=YgXx
-----END PGP SIGNATURE-----
