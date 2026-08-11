#!/usr/bin/env playonlinux-bash
# Date : (2017-01-24)
# Last revision : (2018-09-15 10:02)
# Distribution used to test : Ubuntu 16.04 LTS with NVIDIA geforce GTX 770 (lathis), Ubuntu 18.04 with Palit GeForce GTX 1070 (LinuxScripter)
# Author : lahtis, LinuxScripter
# Script licence : GPL3
# Licence : retail
# This installer pictures files found https://github.com/lahtis/playonlinux/blob/master/working/Subnautica/
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
        
TITLE="Subnautica"
PREFIX="Subnautica"
WORKING_WINE_VERSION="3.14"
AUTHOR="lahtis, LinuxScripter"
EDITOR="Unknown Worlds"
GAME_URL="https://unknownworlds.com/subnautica/"
        
# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 3299
POL_Debug_Init
             
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
        
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
  
POL_Call POL_Function_SetResolution
       
# Moving to TMP dir
cd "$POL_System_TmpDir"
      
# Installing mandatory dependencies
POL_Call POL_Install_corefonts #Steam UI is textless without it
POL_Call POL_Install_vcrun2013 #needed by the game itself
 
# Registery fix for the game crashing after quiting
cat << EOF > fix.reg
REGEDIT4
        
[HKEY_CURRENT_USER\Software\Wine\X11 Driver]
"UseTakeFocus"="N"

EOF
       
POL_Wine regedit.exe fix.reg
 
# Installing Steam
POL_SetupWindow_message "$(eval_gettext 'Do NOT launch Steam after instalation. Uncheck the Launch Steam option at the end of installation. Otherwise the game instalation will fail due to missing content servers in config file.')"
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam/config"
sed '27i                                "CS"                "valve511.steamcontent.com;valve501.steamcontent.com;valve517.steamcontent.com;valve557.steamcontent.com;valve513.steamcontent.com;valve535.steamcontent.com;valve546.steamcontent.com;valve538.steamcontent.com;valve536.steamcontent.com;valve530.steamcontent.com;valve559.steamcontent.com;valve545.steamcontent.com;valve518.steamcontent.com;valve548.steamcontent.com;valve555.steamcontent.com;valve556.steamcontent.com;valve506.steamcontent.com;valve544.steamcontent.com;valve525.steamcontent.com;valve567.steamcontent.com;valve521.steamcontent.com;valve510.steamcontent.com;valve542.steamcontent.com;valve519.steamcontent.com;valve526.steamcontent.com;valve504.steamcontent.com;valve500.steamcontent.com;valve554.steamcontent.com;valve562.steamcontent.com;valve524.steamcontent.com;valve502.steamcontent.com;valve505.steamcontent.com;valve547.steamcontent.com;valve560.steamcontent.com;valve503.steamcontent.com;valve507.steamcontent.com;valve553.steamcontent.com;valve520.steamcontent.com;valve550.steamcontent.com;valve531.steamcontent.com;valve558.steamcontent.com;valve552.steamcontent.com;valve563.steamcontent.com;valve540.steamcontent.com;valve541.steamcontent.com;valve537.steamcontent.com;valve528.steamcontent.com;valve523.steamcontent.com;valve512.steamcontent.com;valve532.steamcontent.com;valve561.steamcontent.com;valve549.steamcontent.com;valve522.steamcontent.com;valve514.steamcontent.com;valve551.steamcontent.com;valve564.steamcontent.com;valve543.steamcontent.com;valve565.steamcontent.com;valve529.steamcontent.com;valve539.steamcontent.com;valve566.steamcontent.com;valve165.steamcontent.com;valve959.steamcontent.com;valve164.steamcontent.com;valve1611.steamcontent.com;valve1601.steamcontent.com;valve1617.steamcontent.com;valve1603.steamcontent.com;valve1602.steamcontent.com;valve1610.steamcontent.com;valve1615.steamcontent.com;valve909.steamcontent.com;valve900.steamcontent.com;valve905.steamcontent.com;valve954.steamcontent.com;valve955.steamcontent.com;valve1612.steamcontent.com;valve1607.steamcontent.com;valve1608.steamcontent.com;valve1618.steamcontent.com;valve1619.steamcontent.com;valve1606.steamcontent.com;valve1605.steamcontent.com;valve1609.steamcontent.com;valve907.steamcontent.com;valve901.steamcontent.com;valve902.steamcontent.com;valve1604.steamcontent.com;valve908.steamcontent.com;valve950.steamcontent.com;valve957.steamcontent.com;valve903.steamcontent.com;valve1614.steamcontent.com;valve904.steamcontent.com;valve952.steamcontent.com;valve1616.steamcontent.com;valve1613.steamcontent.com;valve958.steamcontent.com;valve956.steamcontent.com;valve906.steamcontent.com"' config.vdf > config.vdf
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/264710
POL_Wine_WaitBefore "$TITLE"
       
# Shortcut
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/264710" "-no-ces-sandbox"
POL_SetupWindow_message "$(eval_gettext 'If the game crashes at startup, open a terminal and type:\necho 0|sudo tee /proc/sys/kernel/yama/ptrace_scope')"
POL_SetupWindow_message "$(eval_gettext 'Remember to go to Configure menu and write fixme-all in debug flags. This will increase the game's performance.')"
    
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlyIL/EACgkQ5TH6yaoTykejpACfZK1h1pOBAVKOs4deVzfxyaQh
PSIAn1XZUj47uUMfZoTqk+P61HlY8hji
=b47h
-----END PGP SIGNATURE-----
