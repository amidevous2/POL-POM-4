#!/bin/bash
# PlayOnLinux Function
# Date : (2010-02-12 21-00)
# Last revision : (2020-06-02 22-50)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com
  
# Setting default path for installers
POL_LoadVar_PROGRAMFILES
  
# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Call POL_Function_FontsSmoothRGB
  
# Fix to prevent Steam from launching without text after update
POL_Wine_OverrideDLL "" "dwrite"


POL_Debug_Message "Installing Steam."
# Installing Steam

# Seems impossible to work (2020-06)
# cd "$WINEPREFIX/drive_c"
# POL_Download "http://media.steampowered.com/client/installer/SteamSetup.exe"

# Disabled because contrary to POL_Download, the MD5 digest is mandatory for POL_Download_Resource
POL_Download_Resource "http://media.steampowered.com/client/installer/SteamSetup.exe" "81448c2e730b50b597bbd5e43007ce6a"
cd "$POL_USER_ROOT/ressources/"

# POL_SetupWindow_wait "$(eval_gettext 'Please complete the Steam setup wizard.')" "$(eval_gettext '$TITLE - Steam Installation')"
POL_SetupWindow_message "Please let complete the Steam setup wizard." "$TITLE"
POL_Wine start /unix "SteamSetup.exe"

# POL_SetupWindow_message "$(eval_gettext 'Log into your Steam account once the update is complete.\n\nClick Next to continue.')" "$TITLE - Steam Update and Login"
POL_SetupWindow_message "Please: once the update is complete,\n#1 do log into your Steam account,\n#2 then click Next to continue." "$TITLE"
  
# Fix for Steam (cause wine crash for many games if enabled) - Empty value = disabled
# Note : semble ne plus être nécessaire désormais?
POL_Wine_OverrideDLL "" "gameoverlayrenderer"
 
# Fix for the "content servers unreachable" error (2015)
cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/config/"
sed '27i                                "CS"                "valve511.steamcontent.com;valve501.steamcontent.com;valve517.steamcontent.com;valve557.steamcontent.com;valve513.steamcontent.com;valve535.steamcontent.com;valve546.steamcontent.com;valve538.steamcontent.com;valve536.steamcontent.com;valve530.steamcontent.com;valve559.steamcontent.com;valve545.steamcontent.com;valve518.steamcontent.com;valve548.steamcontent.com;valve555.steamcontent.com;valve556.steamcontent.com;valve506.steamcontent.com;valve544.steamcontent.com;valve525.steamcontent.com;valve567.steamcontent.com;valve521.steamcontent.com;valve510.steamcontent.com;valve542.steamcontent.com;valve519.steamcontent.com;valve526.steamcontent.com;valve504.steamcontent.com;valve500.steamcontent.com;valve554.steamcontent.com;valve562.steamcontent.com;valve524.steamcontent.com;valve502.steamcontent.com;valve505.steamcontent.com;valve547.steamcontent.com;valve560.steamcontent.com;valve503.steamcontent.com;valve507.steamcontent.com;valve553.steamcontent.com;valve520.steamcontent.com;valve550.steamcontent.com;valve531.steamcontent.com;valve558.steamcontent.com;valve552.steamcontent.com;valve563.steamcontent.com;valve540.steamcontent.com;valve541.steamcontent.com;valve537.steamcontent.com;valve528.steamcontent.com;valve523.steamcontent.com;valve512.steamcontent.com;valve532.steamcontent.com;valve561.steamcontent.com;valve549.steamcontent.com;valve522.steamcontent.com;valve514.steamcontent.com;valve551.steamcontent.com;valve564.steamcontent.com;valve543.steamcontent.com;valve565.steamcontent.com;valve529.steamcontent.com;valve539.steamcontent.com;valve566.steamcontent.com;valve165.steamcontent.com;valve959.steamcontent.com;valve164.steamcontent.com;valve1611.steamcontent.com;valve1601.steamcontent.com;valve1617.steamcontent.com;valve1603.steamcontent.com;valve1602.steamcontent.com;valve1610.steamcontent.com;valve1615.steamcontent.com;valve909.steamcontent.com;valve900.steamcontent.com;valve905.steamcontent.com;valve954.steamcontent.com;valve955.steamcontent.com;valve1612.steamcontent.com;valve1607.steamcontent.com;valve1608.steamcontent.com;valve1618.steamcontent.com;valve1619.steamcontent.com;valve1606.steamcontent.com;valve1605.steamcontent.com;valve1609.steamcontent.com;valve907.steamcontent.com;valve901.steamcontent.com;valve902.steamcontent.com;valve1604.steamcontent.com;valve908.steamcontent.com;valve950.steamcontent.com;valve957.steamcontent.com;valve903.steamcontent.com;valve1614.steamcontent.com;valve904.steamcontent.com;valve952.steamcontent.com;valve1616.steamcontent.com;valve1613.steamcontent.com;valve958.steamcontent.com;valve956.steamcontent.com;valve906.steamcontent.com"' config.vdf > config.vdf

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXtbFeQAKCRDlMfrJqhPK
Ry+CAJ9XbEo2KnRNA3UuaphuA4/pcmayagCfR5ll1Q1kHwFZguhJUfIg8x214nE=
=XnVX
-----END PGP SIGNATURE-----
