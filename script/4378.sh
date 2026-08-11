#!/usr/bin/env playonlinux-bash
# Date : (2021-05-26 20-57)
# Last revision : (2021-05-26 21-20)
# Author : Yaotl
# Script licence : GPL3

# Download PhysX Legacy
POL_Download_Resource "https://us.download.nvidia.com/Windows/9.13.0604/PhysX-9.13.0604-SystemSoftware-Legacy.msi" "c73bd5c9631735b8c2d071aa05a7b598"

# Installing PhysX Legacy
POL_Wine msiexec /i "PhysX-9.13.0604-SystemSoftware-Legacy.msi" /q
POL_Wine_WaitExit "PhysX Legacy"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLXiaQAKCRDlMfrJqhPK
Rx2pAJ9zQnK6ykVTES66lM9f/rr5iyYNlwCeL0J9IftWMyHJHT3jeaBkD4vohCU=
=ZVFP
-----END PGP SIGNATURE-----
