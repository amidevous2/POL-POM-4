#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

FULLNAME="Strong Bad Episode 2: Strong Badia the Free"
COMPANY="Telltale Games"
WEBSITE="http://www.telltalegames.com/strongbad"
SCRIPTER="Kjella"
CODENAME="strongbad-102"

INSTDIR="http://www.telltalegames.com/download"
INSTNAME="strongbadiathefree"

ICONDIR="http://www.telltalegames.com/images/productshots"
ICONNAME="sbcg4ap102_139x110.png"

LINKDIR="Program Files/Telltale Games/Strong Bad/Episode 2 - Strong Badia the Free/"
LINKFILE="Homestar102.exe"
LINKNAME="Strong Bad 102: Strong Badia the Free"

# Basic setup
POL_SetupWindow_Init
POL_SetupWindow_presentation "$FULLNAME" "$COMPANY" "$WEBSITE" "$SCRIPTER" "$CODENAME"
select_prefixe "$REPERTOIRE/wineprefix/$CODENAME"
POL_SetupWindow_prefixcreate

mkdir -p $WINEPREFIX/drive_c/download/
cd $WINEPREFIX/drive_c/download/

POL_SetupWindow_message "Installing DirectX" "Installing DirectX"
# Download winetricks
wget http://www.kegel.com/wine/winetricks
chmod +x winetricks
./winetricks -q directx9

# Unregister everything winetricks did
rm -f dll.reg
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > dll.reg
echo "\"d3dim\"=\"builtin\"" >> dll.reg
echo "\"d3drm\"=\"builtin\"" >> dll.reg
echo "\"d3dx8\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_24\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_25\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_26\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_27\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_28\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_29\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_30\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_31\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_32\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_33\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_34\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_35\"=\"builtin\"" >> dll.reg
echo "\"d3dx9_36\"=\"builtin\"" >> dll.reg
echo "\"d3dxof\"=\"builtin\"" >> dll.reg
echo "\"dciman32\"=\"builtin\"" >> dll.reg
echo "\"ddrawex\"=\"builtin\"" >> dll.reg
echo "\"devenum\"=\"builtin\"" >> dll.reg
echo "\"dinput\"=\"builtin\"" >> dll.reg
echo "\"dinput8\"=\"builtin\"" >> dll.reg
echo "\"dmband\"=\"builtin\"" >> dll.reg
echo "\"dmcompos\"=\"builtin\"" >> dll.reg
echo "\"dmime\"=\"builtin\"" >> dll.reg
echo "\"dmloader\"=\"builtin\"" >> dll.reg
echo "\"dmscript\"=\"builtin\"" >> dll.reg
echo "\"dmstyle\"=\"builtin\"" >> dll.reg
echo "\"dmsynth\"=\"builtin\"" >> dll.reg
echo "\"dmusic\"=\"builtin\"" >> dll.reg
echo "\"dmusic32\"=\"builtin\"" >> dll.reg
echo "\"dnsapi\"=\"builtin\"" >> dll.reg
echo "\"dplay\"=\"builtin\"" >> dll.reg
echo "\"dplayx\"=\"builtin\"" >> dll.reg
echo "\"dpnaddr\"=\"builtin\"" >> dll.reg
echo "\"dpnet\"=\"builtin\"" >> dll.reg
echo "\"dpnhpast\"=\"builtin\"" >> dll.reg
echo "\"dpnlobby\"=\"builtin\"" >> dll.reg
echo "\"dsound\"=\"builtin\"" >> dll.reg
echo "\"dswave\"=\"builtin\"" >> dll.reg
echo "\"dxdiagn\"=\"builtin\"" >> dll.reg
echo "\"mscoree\"=\"builtin\"" >> dll.reg
echo "\"msdmo\"=\"builtin\"" >> dll.reg
echo "\"qcap\"=\"builtin\"" >> dll.reg
echo "\"quartz\"=\"builtin\"" >> dll.reg
echo "\"streamci\"=\"builtin\"" >> dll.reg
regedit dll.reg

# Add the one we do need
rm -f dll.reg
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > dll.reg
echo "\"d3dx9_36\"=\"native,builtin\"" >> dll.reg
regedit dll.reg

# Install game
cd $PLAYONLINUX/tmp/
POL_SetupWindow_download "Downloading installer from $COMPANY" "Downloading installer" "$INSTDIR/$INSTNAME"
mv $INSTNAME $CODENAME.exe
wine $CODENAME.exe
rm $CODENAME.exe

### Custom: Remove WINE desktop icon
rm ~/Desktop/Episode\ 2\ -\ Strong\ Badia\ the\ Free.desktop

# Set up the shortcut
cd $REPERTOIRE/icones
wget $ICONDIR/$ICONNAME
mv $ICONNAME $CODENAME.png
POL_SetupWindow_make_shortcut "$CODENAME" "$LINKDIR" "$LINKFILE" "$CODENAME.png" "$LINKNAME"
Set_WineVersion_Assign "1.1.5" "$LINKNAME"

if [ "$POL_LANG" == "fr" ]; then 
POL_SetupWindow_message "Voici comment faire fonctionner le jeu.\n1.Entrez le serial (obtenu après création d'un compte valide sur le site de Telltale)\n2. Alt+F4 pour fermer la fenêtre.\n3. Relancer le jeu et cliquez sur le lien pour démarrer.\n4. Après avoir réglé la résolution et/ou le mode fenêtré, faite Alt+F4 pour sortir. Les paramêtres seront appliqués au prochains lancement." "Instructions pour faire fonctionner le jeu" 4 4 0 "" "Terminer"
else 
POL_SetupWindow_message "Use these steps to play the game.\n1. Enter serial (found in account section on telltale site)\n2. Alt + F4 to close.\n3. Run again and click the link to run.\n4. After changing to windowed mode or resolution, press Alt+F4 to exit.\nChanges are applied next time you start the game." "Information about running the episode"
fi

# Cleanup
POL_SetupWindow_reboot
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEsACgkQ5TH6yaoTykcUNACcC0Ooo3lDMlw73BpR9ETl1B+U
n+QAn0oVRtG2y8gx7HS/48pr1hCjwTjs
=mZEb
-----END PGP SIGNATURE-----
