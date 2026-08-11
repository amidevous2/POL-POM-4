#!/bin/bash
# Date : (2010-14-11 21-00)
# Last revision : (2019-04-23 10-27)
# Only For : http://www.playonlinux.com
# RealName: Flash Player
  
# CHANGELOG
# [Dadu042] (2019-04-23)
#   MD5 mismatch

# [The.One] (2016-12-29)
#   MD5 mismatch
 
# [QUENTIN PÂRIS] (2016-08-21)
#   Link broken
#
# [VV] (2013-12-02 21-09)
#   Update script (link broken)
  
# [Quentin PÂRIS] (2012-11-21 18-19)
#   Update script (link broken)
  
# [SuperPlumus] (2012-05-18 06-42)
#   Update script (broken)
  
# [Tutul] (2014-11-19 17-20)
#   Update script (broken)
  
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "https://fpdownload.macromedia.com/pub/flashplayer/latest/help/install_flash_player.exe"
POL_Wine_WaitBefore "Flash Player"
POL_Wine "install_flash_player.exe"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOZOTwAKCRDlMfrJqhPK
R1ZSAKCCLiYL2+hRYfadnTMH87E0JzpUJACdGZrqR5ok64PV0PTqESEjYWIvrWA=
=1Ef2
-----END PGP SIGNATURE-----
