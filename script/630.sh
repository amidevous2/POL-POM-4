#!/bin/bash
# Date : (2010-05-8 18-55)
# Last revision : (2010-05-18 16-15)
# Wine version used : 1.1.43
# Distribution used to test : Ubuntu 10.04 32bit
# Author : Joe21
# Licence : none
# Depend : none
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "Pizza Syndicate" "Software 2000" "No website" "Joe21" "PizzaSyndicate"
 
POL_SetupWindow_message "PROBLEM: The games setup program may require you to refocus\nits window when progressing between screens and after the pizza\ncountdown reaches 100. This bug is also present when you launch\nthe game.\n\nSOLUTION in Gnome: \nUsing alt+tab - \n1)Switch from the setup/game to playonlinux\n2)Then switch back." "" "$PLAYONLINUX/themes/tango/warning.png"
 
select_prefix "$REPERTOIRE/wineprefix/PizzaSyndicate"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.exe"
 
POL_SetupWindow_install_wine "1.1.43"
Use_WineVersion "1.1.43"
 
POL_SetupWindow_prefixcreate
 
Set_OS "win98"
 
POL_SetupWindow_wait_next_signal "Running Installation..." "Pizza Syndicate"
wine "$CDROM/SETUP.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_make_shortcut "PizzaSyndicate" "Pizza Syndicate" "Pizza.exe" "Syndicate.ico" "Pizza Syndicate" "" ""
Set_WineVersion_Assign "1.1.43" "Pizza Syndicate"
 
POL_SetupWindow_message "Installation Successful."
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTykfncQCgghvwArBo8R9HfDYoMKkLDey8
ZT8Ani2MUaI5bnDJnFTHetggRMdo0euG
=nDI3
-----END PGP SIGNATURE-----
