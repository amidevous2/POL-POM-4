#!/bin/bash
# Date : (2010-05-01 18-00)
# Last revision : (2010-05-01 18-00)
# Wine version used : 1.1.43
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick, unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Croc Legend of the Gobbos"
PREFIX="CrocI"
WORKINGWINEVERSION="1.1.43"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
rm -f "$REPERTOIRE/icones/$1.ico"
}

#starting the script
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TYTUL" "Argonaut Software" "N/A" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking for CDROM and checking if it's correct one
POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "./Setup/Setup.exe"

#downloading specific Wine
POL_SetupWindow_install_wine "1.1.2"
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#creating application's own prefix
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

#adding CD-ROM as drive e: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

#starting installation
wine start /unix "$CDROM/Setup/Setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

#asking about memory size of graphic card
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-890-1024-2048" "-" "256"
VMS="$APP_ANSWER"

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

#setting Glide compatible with Voodoo
echo "[HKEY_LOCAL_MACHINE\\Software\\Argonaut Software\\Croc]" > glide.reg
echo "\"Driver name\"=\"3dfx_win\"" >> glide.reg
regedit glide.reg

cd "$REPERTOIRE/ressources"
#downloading Zeckensack's Glide wrapper
if [ ! -e "GlideWrapper084c.exe" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading Zeckensack's Glide wrapper" "Zeckensack's Glide wrapper" "http://www.zeckensack.de/glide/archive/GlideWrapper084c.exe"
fi
#downloading dgVoodoo Glide wrapper
if [ ! -e "dgVoodoo1.50Beta2.zip" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading dgVoodoo Glide wrapper" "dgVoodoo Glide wrapper" "http://dege.freeweb.hu/dgVoodoo1.50Beta2.zip"
fi

#installing Zeckensack's Glide wrapper
POL_SetupWindow_wait_next_signal "Installation in progress..." "Zeckensack's Glide wrapper"
wine GlideWrapper084c.exe
POL_SetupWindow_detect_exit

#installing dgVoodoo Glide wrapper
POL_SetupWindow_wait_next_signal "Installation in progress..." "Zeckensack's Glide wrapper"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Fox/Croc"
mv *lide2x.dll glide2x.dll.org
unzip "$REPERTOIRE/ressources/dgVoodoo1.50Beta2.zip"
mv glide2x.dll glide2x.dll.dgVoodoo #default Glide wrapper will be Zeckensack
POL_SetupWindow_detect_exit

#preparing Wine version
cd "$REPERTOIRE/WineVersions"
cp "$WORKINGWINEVERSION" "$WORKINGWINEVERSION-Croc"
rm -f "./$WORKINGWINEVERSION-Croc/usr/lib/wine/wined3d.dll.so"
rm -f "./$WORKINGWINEVERSION-Croc/usr/lib/wine/ddraw.dll.so"

cp "./$WORKINGWINEVERSION/usr/lib/wine/wined3d.dll.so" "./$WORKINGWINEVERSION-Croc/usr/lib/wine/wined3d.dll.so"
cp "./$WORKINGWINEVERSION/usr/lib/wine/ddraw.dll.so" "./$WORKINGWINEVERSION-Croc/usr/lib/wine/ddraw.dll.so"

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi

#making shortcut 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Fox/Croc" "CrocRun.exe" "" "$TYTUL" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION-Croc" "$TYTUL"
POL_SetupWindow_make_icon_for_shortcut "$TYTUL" "*_crocrun.0.xpm"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/GlideWrapper" "configurator.exe" "" "Croc Zeckensack configurator" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION-Croc" "Croc Zeckensack configurator"

#Adding configurator for changing Glide wrappers
cat << EOF > "$REPERTOIRE/configurations/configurators/$TYTUL"
#!/bin/bash
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init
cd "$REPERTOIRE/configurations/installed"
if [ -e "Croc Zeckensack configurator" ]; then
rm -f "Croc Zeckensack configurator"
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Fox/Croc/glide2x.dll.dgVoodoo" "$WINEPREFIX/drive_c/$PROGRAMFILES/Fox/Croc/glide2x.dll"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Fox/Croc" "dgVoodooSetup.exe" "" "Croc dgVoodoo configurator" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION-Croc" "Croc dgVoodoo configurator"

elif [ -e "Croc dgVoodoo configurator" ]; then
rm -f "Croc dgVoodoo configurator"
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Fox/Croc/glide2x.dll" "$WINEPREFIX/drive_c/$PROGRAMFILES/Fox/Croc/glide2x.dll.dgVoodoo"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/GlideWrapper" "configurator.exe" "" "Croc Zeckensack configurator" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION-Croc" "Croc Zeckensack configurator"
fi
POL_SetupWindow_Close

EOF

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about NVIDIA GeForce 4
POL_SetupWindow_question "Do you've got NVIDIA GeForce 4 graphic card?" "$TYTUL" 
if [ "$APP_ANSWER" == "TRUE" ] ;then

cd "$WINEPREFIX/drive_c/windows/temp/"
#setting D3DHW
echo "[HKEY_LOCAL_MACHINE\\Software\\Argonaut Software\\Croc]" > glide.reg
echo "\"Driver name\"=\"d3drend\"" >> glide.reg
regedit glide.reg

else
POL_SetupWindow_message "If you want high screen resolution you must change Glide Wrapper.\nTo do so please run \"Configure this application\"\nfrom main PlayOnLinux window and select latest option" "Glide wrapper" "$PLAYONLINUX/themes/tango/info.png"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFwACgkQ5TH6yaoTykcXXACcCiw99XPJ3KU9tV741sFgd3Xo
0yYAnRIcErLWCfoFmG65N6adbAzffyJw
=EqpQ
-----END PGP SIGNATURE-----
