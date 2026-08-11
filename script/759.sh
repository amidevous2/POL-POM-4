#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-28 09-16)
# Last revision : (2012-04-10 14-12)
# Author : SuperPlumus
 
POL_Call POL_Install_vcrun6
POL_Call POL_Install_vcrun2008
 
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://www.koepi.info/Xvid-1.3.2-20110601.exe" "b1bbd74395a34ff7fd069d3b6fe23016"

POL_Wine_WaitBefore "Xvid"
POL_Wine "Xvid-1.3.2-20110601.exe" --mode unattended --decode_divx 1 --decode_3ivx 1 --decode_other 1

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+EJJkACgkQ5TH6yaoTykdgtgCgoI09s3lNSHTMqB+m//AB35qB
3VMAn0039YKDoM3Hl6bTI5Fp8xNXmHCS
=nQBh
-----END PGP SIGNATURE-----
