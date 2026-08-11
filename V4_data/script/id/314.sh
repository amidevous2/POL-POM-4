#!/bin/bash 
if [ "$PLAYONLINUX" = "" ] 
then 
exit 0 
fi 
source "$PLAYONLINUX/lib/sources" 
cfg_check 
 
wget http://upload.wikimedia.org/wikipedia/en/8/8e/The_Elder_Scrolls_III_-_Bloodmoon_Coverart.png --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "The Elder Scrolls 3 : Bloodmoon" "Bethesda Softworks" "http://bethsoft.com" "Lordheavy" "ElderScrolls3_Morrowind" 
 
verifier_installation_e "ElderScrolls3_Morrowind"
 
POL_SetupWindow_cdrom 
POL_SetupWindow_check_cdrom "Setup.exe" 
 
select_prefixe "$REPERTOIRE/wineprefix/ElderScrolls3_Morrowind" 
 
POL_SetupWindow_wait_next_signal "Installation in progress..." "TES3: Bloodmoon" 
wine $CDROM/Setup.exe 
POL_SetupWindow_detect_exit 

POL_SetupWindow_reboot 
POL_SetupWindow_Close 
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEoACgkQ5TH6yaoTykcg2wCfeMtPA+myYfrFqG69FYv29dkR
2roAoI5KrgUPN9/e2Q6k2mBD14btAYfX
=pWWJ
-----END PGP SIGNATURE-----
