#!/bin/bash
# Date : (2013-04-28 18-36)
# Last revision : (2013-04-28 18-36)
# Author : petch
# Only For : http://www.playonlinux.com


# Just to be on the safe side
[ -n "$WINEPREFIX" ] || POL_Debug_Fatal "POL_Function_PrivateUserDirs: Variable WINEPREFIX not set!"

find "$WINEPREFIX/drive_c/" -type l -exec sh -c 'echo "fixing {}"; rm "{}"; mkdir "{}"; touch "{}/.fixed"' \;

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlW4cYEACgkQ5TH6yaoTykeHDgCdGa2UdpvDppEHiu0G/kkPnNPX
i7oAn2Doa6QVvLXfGw/lh359sFssJ4Rn
=x9Br
-----END PGP SIGNATURE-----
