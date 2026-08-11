#!/bin/bash
# PlayOnLinux Function
# Date : see changelog
# Last revision : see changelog
# Author : Unknown
# Only For : http://www.playonlinux.com

# CHANGELOG:
# [Unknown] (?)
#   Initial script.
# [GNU_Raziel] (2011-08-28 21:00)
#   Update
# [Dadu042] (2020-10-12 14-00)
#   Attempt to make it easier to understand.
# [Dadu042] (2020-10-12 14-30)
#   Attempt to add Gecko v2.47 for Wine v1.9.13 to v3.x.x .
#   Note: the current default Gecko version is still v1.3.0 (2011 ?).

# Check if Gecko is already installed (otherwise do exit this script).
unset GECKO_EXIST
GECKO_EXIST=`find $WINEPREFIX -name "xul.dll"`
if [ ! -n "$GECKO_EXIST" ]; then
# Load the HTML rendering Engine (Gecko)
WINDIR="$WINEPREFIX/drive_c/windows/"
case `wine --version` in
wine-0*|wine-1.0*|wine-1.1|wine-1.1.?|wine-1.1.11)
        GECKO_DIR="$WINDIR"
        GECKO_VERSION=0.1.0
        GECKO_SHA1SUM=c16f1072dc6b0ced20935662138dcf019a38cd56
        GECKO_EXT=cab
        ;;
wine-1.1.1[234]*)
        GECKO_DIR="$WINDIR"
        GECKO_VERSION=0.9.0
        GECKO_SHA1SUM=5cf410ff7fdd3f9d625f481f9d409968728d3d09
        GECKO_EXT=cab
        ;;
wine-1.1.1[56789]*|wine-1.1.2[0123456]*)
        GECKO_DIR="$WINDIR"
        GECKO_VERSION=0.9.1
        GECKO_SHA1SUM=9a49fc691740596517e381b47096a4bdf19a87d8
        GECKO_EXT=cab
        ;;
esac
# x86_64 gecko package for wine64
if [ -e "$WINDIR/syswow64" ]; then
case `wine --version` in
wine-1.1.2[789]*|wine-1.2*|wine-1.3|wine-1.3.1)
        GECKO_DIR="$WINDIR/syswow64"
        GECKO_VERSION=1.0.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=afa22c52bca4ca77dcb9edb3c9936eb23793de01
        GECKO_EXT=cab
        ;;
wine-1.3.[23456789]|wine-1.3.1[012345])
        GECKO_DIR="$WINDIR/syswow64"
        GECKO_VERSION=1.1.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=1b6c637207b6f032ae8a52841db9659433482714
        GECKO_EXT=cab
        ;;
wine-1.3.1[6789]|wine-1.3.2[012345])
        GECKO_DIR="$WINDIR/syswow64"
        GECKO_VERSION=1.2.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=6964d1877668ab7da07a60f6dcf23fb0e261a808
        GECKO_EXT=msi
        ;;
wine-1.9.1[3456789]|wine-2|wine-3)
        GECKO_DIR="$WINDIR/syswow64"
        GECKO_VERSION=2.47
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=5ebc4ec71c92b3db3d84b334a1db385d
        GECKO_EXT=msi
        ;;
*)
        GECKO_DIR="$WINDIR/syswow64"
        GECKO_VERSION=1.3.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=6964d1877668ab7da07a60f6dcf23fb0e261a808
        GECKO_EXT=msi
        ;;
esac
else
case `wine --version` in
wine-1.1.2[789]*|wine-1.2*|wine-1.3|wine-1.3.1)
        GECKO_DIR="$WINDIR/system32"
        GECKO_VERSION=1.0.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=afa22c52bca4ca77dcb9edb3c9936eb23793de01
        GECKO_EXT=cab
        ;;
wine-1.3.[23456789]|wine-1.3.1[012345])
        GECKO_DIR="$WINDIR/system32"
        GECKO_VERSION=1.1.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=1b6c637207b6f032ae8a52841db9659433482714
        GECKO_EXT=cab
        ;;
wine-1.3.1[6789]|wine-1.3.2[012345])
        GECKO_DIR="$WINDIR/system32"
        GECKO_VERSION=1.2.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=6964d1877668ab7da07a60f6dcf23fb0e261a808
        GECKO_EXT=msi
        ;;
wine-1.9.1[3456789]|wine-2|wine-3)
        GECKO_DIR="$WINDIR/system32"
        GECKO_VERSION=2.47
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=d93ac0d2e6aceafe9113a9918916df45
        GECKO_EXT=msi
	;;
*)
        GECKO_DIR="$WINDIR/system32"
        GECKO_VERSION=1.3.0
        GECKO_ARCH=-x86
        GECKO_SHA1SUM=6964d1877668ab7da07a60f6dcf23fb0e261a808
        GECKO_EXT=msi
        ;;
esac
fi
 
# From this code: 
# http://downloads.sourceforge.net/wine/wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT"
# the final URL is:
# http://downloads.sourceforge.net/wine/wine_gecko-1.3.0-x86.msi
# And as of 2020-10-12, this URL to this file is dead...

if test ! -f "$POL_USER_ROOT/ressources/wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT"
then

	POL_Download_Resource "http://downloads.sourceforge.net/wine/wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT"  "Gecko"

	# Obsolete code (since POL v3 or v4):
	# POL_SetupWindow_download "$(eval_gettext 'Downloading Gecko ...')" "$TITLE" "http://downloads.sourceforge.net/wine/wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT"
        # mv wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT "$POL_USER_ROOT/ressources/wine_gecko-$GECKO_VERSION$GECKO_ARCH.$GECKO_EXT"
fi
 
# Extract files
if [ "$GECKO_EXT" == "cab" ]; then
        mkdir -p "$GECKO_DIR/gecko/$GECKO_VERSION"
        cd "$GECKO_DIR/gecko/$GECKO_VERSION"
        cabextract "$POL_USER_ROOT/ressources/wine_gecko-$GECKO_VERSION$GECKO_ARCH.cab"
        cd "$olddir"
else
        POL_Wine msiexec /i "$POL_USER_ROOT/ressources/wine_gecko-$GECKO_VERSION$GECKO_ARCH.msi"
        cd "$olddir"
fi
 
 
cat > "$POL_USER_ROOT/tmp/geckopath.reg" <<_EOF_
REGEDIT4
 
[HKEY_LOCAL_MACHINE\\Software\\Wine\\MSHTML\\$GECKO_VERSION]
_EOF_
 
printf '"GeckoPath"="' >>"$POL_USER_ROOT/tmp/geckopath.reg"
case $GECKO_VERSION in
0.*)
        printf 'c:\\windows\\gecko\\'$GECKO_VERSION'\\wine_gecko\\"' |
        sed "s/\\\\/\\\\\\\\/g" >> "$POL_USER_ROOT/tmp/geckopath.reg"
        ;;
esac
# x86 gecko path for wine64
if [ -e "$WINDIR/syswow64" ]; then
case $GECKO_VERSION in
1.*)
        printf 'c:\\windows\\syswow64\\gecko\\'$GECKO_VERSION'\\wine_gecko\\"' |
        sed "s/\\\\/\\\\\\\\/g" >> "$POL_USER_ROOT/tmp/geckopath.reg"
        ;;
esac
else
case $GECKO_VERSION in
1.*)
        printf 'c:\\windows\\system32\\gecko\\'$GECKO_VERSION'\\wine_gecko\\"' |
        sed "s/\\\\/\\\\\\\\/g" >> "$POL_USER_ROOT/tmp/geckopath.reg"
        ;;
esac
fi
 
# Set installation path
POL_Wine regedit "$POL_USER_ROOT/tmp/geckopath.reg"
     
# Register the dll, since it was disabled before
POL_Wine regsvr32 mshtml
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX4RbTgAKCRDlMfrJqhPK
R8+YAKCCaVkMGYllOhHynf65dYvUX0X/AQCbBuFt3MAio2aUOe/Qftc4W2YcEbA=
=lOBv
-----END PGP SIGNATURE-----
