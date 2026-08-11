#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-28 09-16)
# Last revision : (2015-12-31 02-26)
# Author : SuperPlumus
 
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://files.playonlinux.com/ffdshow_beta7_rev3154_20091209.exe" "c3f75f29521f749f9c9fc5489544cb04"
 
POL_Wine_WaitBefore "ffdshow"
POL_Wine "ffdshow_beta7_rev3154_20091209.exe" /silent

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaEhFoACgkQ5TH6yaoTykfVhACgpie4hWDNEVjyXJYAr/d3C5jj
HEoAn010A4V0X8CZrL1bs1eclh1Mmrvl
=cSud
-----END PGP SIGNATURE-----
