#!/bin/bash
# Date : (2016-05-22)
# Last revision : see changelog
# Wine version used : System
# Distribution used to test : xUbuntu 16.04
# Licence : GPLv3
# This script was tested using Final Fantasy XIV - A Realm Reborn downloaded from http://www.finalfantasyxiv.com/playersdownload/eu/
#
# CHANGELOG
# [Dadu042] (2020-01-01)
#   First script (xUbuntu 16.04).
# [Dadu042] (2020-01-01)
#   Wine 1.9.10 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Final Fantasy XIV - A Realm Reborn"
PREFIX="FFXIV"
WORKINGWINEVERSION="3.0.3"
  
POL_GetSetupImages "https://www.alcor.se/FFXIV_TOP.png" "https://www.alcor.se/FFXIV_LEFT.png" "$TITLE"
  
POL_SetupWindow_Init
POL_SetupWindow_SetID 1999
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Square Enix" "http://www.square-enix.com/" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_InstallMethod "DOWNLOAD"
  
# Create prefix and select wine version
POL_Wine_SelectPrefix "$PREFIX"
# POL_Wine_PrefixCreate "$WORKINGWINEVERSION"
Set_OS win7
 
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
    # Run installer
    POL_Download "http://gdl.square-enix.com/ffxiv/inst/ffxivsetup.exe"
    POL_SetupWindow_message "$(eval_gettext 'The launcher will now be installed (After you press next).\nPlease install DirectX when asked to.\nAfter the installation the launcher will automatically start.\nPlease login when it does to let the game be downloaded and installed.\nWhen the game has finished please start the game once and then close it to continue the setup.\n\nPlease be patient as the installation may take some time.\n\n==Known issues==\n* The game will sometimes hang with a black screen when starting. Simply try again.\n* A rogue icon called ffxivsetup will sometimes be created in the POL menu during install. Simply remove it after the installation.\n* If sound is lagging then configure wine to use different sound settings via Wine Configuration. PulseAudio 5.1 Surround works for me.')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start "ffxivsetup.exe"
    POL_Wine_WaitExit "$TITLE"
 
    #Run launcher to create config file, then close it
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/SquareEnix/FINAL FANTASY XIV - A Realm Reborn/boot/"
    POL_Wine start "ffxivboot.exe"
    sleep 5
    killall ffxivboot.exe
 
    #Edit config file to make launcher work properly
    cd "$WINEPREFIX/drive_c/users/$USER/My Documents/My Games/FINAL FANTASY XIV - A Realm Reborn/"
    sed -i 's/BrowserType    0/BrowserType    2/g' FFXIV_BOOT.cfg
 
    # Run launcher and install the game
    #POL_Wine_WaitBefore "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/SquareEnix/FINAL FANTASY XIV - A Realm Reborn/boot/"
    POL_Wine start "ffxivboot.exe"
    #POL_Wine_WaitExit "$TITLE"
 
    POL_SetupWindow_message "$(eval_gettext 'The launcher will now start, login and let the game download.\nAfter that please start the game once and then turn it off together with the launcher, then press next to finish the installation.\n\nThe reason for this is that some changes need to be made to files that do not exist until after the game has started the first time.')" "$TITLE"
    #Edit config file to make game work properly
    cd "$WINEPREFIX/drive_c/users/$USER/My Documents/My Games/FINAL FANTASY XIV - A Realm Reborn/"
    sed -i 's/CutsceneMovieOpening    0/CutsceneMovieOpening    1/g' FFXIV.cfg
    sed -i 's/TextureAnisotropicQuality    0/TextureAnisotropicQuality    2/g' FFXIV.cfg
    sed -i 's/SSAO    1/SSAO    2/g' FFXIV.cfg
    sed -i 's/GrassQuality    2/GrassQuality    3/g' FFXIV.cfg
    sed -i 's/TranslucentQuality    0/TranslucentQuality    1/g' FFXIV.cfg
    sed -i 's/ShadowTextureSizeType    1/ShadowTextureSizeType    2/g' FFXIV.cfg
    sed -i 's/StreamingType    0/StreamingType    1/g' FFXIV.cfg
    sed -i 's/GeneralQuality    1/GeneralQuality    0/g' FFXIV.cfg
    sed -i 's/OcclusionCulling    1/OcclusionCulling    0/g' FFXIV.cfg
    sed -i 's/ReflectionType    0/ReflectionType    2/g' FFXIV.cfg
else
    #Add steam support
    POL_Call POL_Install_steam
fi
 
#Create shortcut
POL_Shortcut "ffxivboot.exe" "$TITLE" "" "" "Game;"
  
#Done!
POL_SetupWindow_message "$(eval_gettext 'Installation finished\n\nYou can mess around with the graphical settings in the game, although the most optimal ones has been set. You are advised to leave HDR and Occlusion Culling settings alone.')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg3fGQAKCRDlMfrJqhPK
R+tgAKCF8VEJgrR3H36Kv4Cb+Ow5rFNMdwCfcY568M9OSxlVmh03Dgce6ut2Wrw=
=7IHZ
-----END PGP SIGNATURE-----
