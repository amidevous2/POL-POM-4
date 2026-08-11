#!/bin/bash
# PlayOnLinux Function

if [ "$WINEPREFIX" = "" ]
then
    POL_Debug_Fatal "sandbox : Variable WINEPREFIX not set !"
fi

POL_Debug_LogToPrefix "Sandboxing prefix : z: ->  $POL_USER_ROOT/tmp/"
POL_Debug_LogToPrefix "Sandboxing prefix : y: ->  $POL_USER_ROOT/ressources/"

rm "$WINEPREFIX/dosdevices/z:"
rm "$WINEPREFIX/dosdevices/y:" 2> /dev/null
ln -s "$POL_USER_ROOT/tmp/" "$WINEPREFIX/dosdevices/z:"
ln -s "$POL_USER_ROOT/ressources/" "$WINEPREFIX/dosdevices/y:"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+H+a0ACgkQ5TH6yaoTykeJPwCgmzIfLs698wOVUZnK4URz+SEA
dJkAoKTHj6J3JV6Z9AeiNUzRfZnfO0hS
=q87/
-----END PGP SIGNATURE-----
