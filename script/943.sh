#!/bin/bash

cat <<EOF > "$REPERTOIRE/tmp/fakeie6.reg"
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer]
"Version"="6.0.2900.2180"

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE]
@="C:\\windows\\command\\iexplore.exe"
"PATH"="c:\\windows\\command"
EOF

POL_Wine regedit "$REPERTOIRE/tmp/fakeie6.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5Xi/QACgkQ5TH6yaoTykea9gCfTpK75Xev/M4zCUTpVTdbKiz/
maAAoJNqJxGPB+K2/T+zqiiZ/vpU4aRF
=1pZH
-----END PGP SIGNATURE-----
