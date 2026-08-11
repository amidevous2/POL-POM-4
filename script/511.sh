#!/bin/bash
# PlayOnLinux Function

# Date : (2009-10-31 17-55)
# Last revision : (2009-10-31 17-55)
# Wine version used : none
# Distribution used to test : none
# Author : Tinou
# Licence : 
# Depend : none

# Note : Do not use POL_SetupWindow_Init
# A basic exemple of function
# Please start the name with POL_Function_ or POL_Install (for the moment)
# Source is not needed
# To run this function in POL : Use, POL_Call POL_Function_sleep [TIME]


[ "$PLAYONLINUX" = "" ] && exit
POL_SetupWindow_wait_next_signal "Please wait ..."
sleep $1
POL_SetupWindow_detect_exit



cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFYACgkQ5TH6yaoTykfcnQCeN0raSQ19WgdIqpY/hd08DZ6A
nPIAnRRI2vza56ZHOskg/lRWfFZP97hv
=M8ES
-----END PGP SIGNATURE-----
