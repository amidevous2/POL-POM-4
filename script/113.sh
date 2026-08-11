# CHANGELOG
# [Toumeno] (2012 ?)
#   First script.
# [Dadu042] (2019-10-30)
#   Wine 1.1.29 -> 2.22
# [Dadu042] (2020-02-05)
#   Fix (outdated) function: POL_SetupWindow_make_shortcut -> POL_Shortcut
#   Update other functions (to POL v4).
#   Wine 2.22 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0 
  
source "$PLAYONLINUX/lib/sources"
  
if [ "$POL_LANG" == "fr" ]
then
LNG_NAME="Pharaon"
LNG_FILE="$PROGRAMFILES/SIERRA/Pharaon/"
else
LNG_NAME="Pharaoh"
LNG_FILE="$PROGRAMFILES/SIERRA/Pharaoh/"
fi
  
cd "$REPERTOIRE/tmp"
rm *.jpg
wget http://upload.wikimedia.org/wikipedia/en/4/46/Pharaoh_Coverart.png --output-document="$REPERTOIRE/tmp/$Prefix.jpg"
convert "$REPERTOIRE/tmp/$Prefix.jpg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
  
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
  
# Presentation
POL_SetupWindow_presentation "$LNG_NAME" "Sierra" "http://pharaoh.heavengames.com/" "Toumeno" "Pharaoh"
 
# Detect the cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
# Prepare Wine
POL_Wine_SelectPrefix "Pharaoh"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0.3"
  
# fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
  
# Setup Wine
Set_OS win98
Set_SoundDriver alsa
Set_Desktop On 1024 768
  
# Installation
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit 
  
POL_Shortcut "Pharaoh.exe" "$LNG_NAME" "" "" "Game;"
POL_Shortcut_Document "$LNG_NAME" "readme.txt"

  
# Create Icon
convert "$CDROM/pharaoh.ico" -geometry 32x32 "$REPERTOIRE/icones/32/$LNG_NAME"
 
POL_SetupWindow_message "Au cours d'une partie, n'oubliez pas de cliquer sur Options=>Affichage,\net de régler la résolution à 1024x768 (maximum).\n\n\nDuring a game, don't forget to click on Options=>Display, and set\nthe resolution on 1024x768 (maximum)."
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjsiIQAKCRDlMfrJqhPK
R9AcAJ9NPLd90VK9VgzzjKSU09LnmcGW/QCcD1Ijz23XPqQhAnkZP+990NyXPFQ=
=qCxo
-----END PGP SIGNATURE-----
