#!/bin/bash
# Date : (2009-07-06 12-00)
# Last revision : (2012-06-23 12-10)
# Wine version used : 1.1.33
# Distribution used to test : Fedora 11
# Author : NSLW
#   modifications by petch
# Licence : Retail
# Depend : ImageMagick, unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Gothic"
PREFIX="Gothic"
WORKINGWINEVERSION="1.1.36"

#procedure for patching Gothic
patch_gothic()
{
    POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
    POL_Wine "$APP_ANSWER"
    POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

Change_Resolution()
{

    if [ -d "$WINEPREFIX/drive_c/$PROGRAMFILES/PiranhaBytes" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/PiranhaBytes/Gothic/system"
    else
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Piranha Bytes/Gothic/System"
    fi

    OLDX=`cat Gothic.ini | grep "zVidResFullscreenX=" | cut -d"=" -f2`
    OLDY=`cat Gothic.ini | grep "zVidResFullscreenY=" | cut -d"=" -f2`
    OLDBPP=`cat Gothic.ini | grep "zVidResFullscreenBPP=" | cut -d"=" -f2`

    POL_SetupWindow_menu_list "Choose display resolution" "Display resolution" "1280x800~1024x768~800x600~640x480" "~"
    RES="$APP_ANSWER"
    POL_SetupWindow_menu_list "Choose color depth" "Color depth" "32~16" "~"
    NEWBPP="$APP_ANSWER"

    NEWX=`echo $RES | cut -d"x" -f1`
    NEWY=`echo $RES | cut -d"x" -f2`
    rm Gothic.ini.bak
    mv Gothic.ini Gothic.ini.bak

    cat Gothic.ini.bak | sed -e "s/zVidResFullscreenX=$OLDX /zVidResFullscreenX=$NEWX/g" | sed -e "s/zVidResFullscreenY=$OLDY/zVidResFullscreenY=$NEWY/g" | sed -e "s/zVidResFullscreenBPP=$OLDBPP/zVidResFullscreenBPP=$NEWBPP/g" > Gothic.ini
}

POL_SetupWindow_wikimedia_left()
{
    wget $1 --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
    convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"

    convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

POL_SetupWindow_wikimedia_left "http://upload.wikimedia.org/wikipedia/en/5/5e/Gothiccover.png"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_presentation "$TYTUL" "Piranha Bytes" "www.piranha-bytes.com" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
    POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game~Change resolution" "~"

    if [ "$APP_ANSWER" = "Patch game" ]; then
        patch_gothic
    elif [ "$APP_ANSWER" = "Change resolution" ]
    then
        Change_Resolution
    fi

    POL_SetupWindow_Close
    exit
fi

POL_SetupWindow_message "Please insert first $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

#taking icon from the game
convert "$CDROM/gothic.ico" -geometry 32X32 "$REPERTOIRE/icones/32/$TYTUL"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"
POL_SetupWindow_prefixcreate

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#adding CD-ROM as drive e: f: to winecfg
CDROM2=${CDROM//"1"/"2"} #GOTHIC_CD2
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:
ln -s "$CDROM2" f:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
echo "\"f:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

#starting installation
POL_Wine "$CDROM/setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"
#POL_SetupWindow_detect_exit

POL_SetupWindow_VMS "32"

POL_Call POL_Install_directmusic

#cleaning temp
#rm -f "$WINEPREFIX/drive_c/windows/temp/"*

#making shortcut
if [ -d "$WINEPREFIX/drive_c/$PROGRAMFILES/PiranhaBytes" ]; then
    POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/PiranhaBytes/Gothic/system" "GOTHIC.EXE" "" "$TYTUL" "" ""
else
    POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Piranha Bytes/Gothic/System" "GOTHIC.EXE" "" "$TYTUL" "" ""
fi

Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL" 
if [ "$APP_ANSWER" = "TRUE" ] ;then
    patch_gothic2
fi

#asking about resolution
POL_SetupWindow_question "Every time you want to change game resolution\nyou'll have to run this script again\nDo you want to change resolution right now?" "$TYTUL"
if [ "$APP_ANSWER" = "TRUE" ] ;then
    Change_Resolution
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/lliYACgkQ5TH6yaoTykcayQCdFxP3cipIHy478yzKEoa49EqQ
4eIAnA63nBtObCn7eILPzYcg3zhUXyrL
=NYKs
-----END PGP SIGNATURE-----
