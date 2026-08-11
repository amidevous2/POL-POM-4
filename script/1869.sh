#!/bin/bash
# Date : (2014-01-07 10-00)
# Distribution used to test : Arch Linux - 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.5
 
 
# check to make sure wineprefix is 32 bit, throw error if not. 32 prefix only.
if [ "$POL_ARCH" == "amd64" ]; then
    POL_Debug_Fatal "64-bit wineprefix is not supported. Please use a 32-bit prefix."
 
# Throw error if user is not in 'audio' group.
elif [ "$(groups | grep -o "audio")" != "audio" ]; then
    POL_Debug_Fatal "$USER is not part of the 'audio' group. Please add $USER to 'audio' group."
     
# Throw an error if jack and/or qjackctl are missing.
elif [ "$(type -P jackd | grep -o "jackd")" != "jackd" ]; then
    POL_Debug_Fatal "Jack is not installed. Please install jack if you want to use WineASIO."
 
elif [ "$(type -P qjackctl | grep -o "qjackctl")" != "qjackctl" ]; then
    POL_Debug_Fatal "QJackCTL is not installed. Please install qjackctl if you want to use WineASIO."
fi
 
# If everything is OK, then download wineasio.dll.so to new $POL_USER_ROOT/tmp

cd $POL_USER_ROOT/tmp
 
POL_Download "http://repo.dusette.net/FOSS/PlayOnLinux/Resources/wineasio.dll.so" "a596dd4de2e12ea8a4284132b6f73a36"
 
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Downloading...')" "WineASIO"
 
# Copy wineasio.dll.so to system32 folder, register, confirm
 
POL_Debug_Message "Installing WineASIO..."
 
cp $POL_USER_ROOT/tmp/wineasio.dll.so $POL_USER_ROOT/wine/linux-x86/$POL_WINEVERSION/lib/wine/wineasio.dll.so
 
if [ "$(POL_Wine regsvr32 $POL_USER_ROOT/wine/linux-x86/$POL_WINEVERSION/lib/wine/wineasio.dll.so | grep -o "Successfully")" != "Successfully" ]; then
    POL_Debug_Fatal "Failed to register wineasio.dll. Please verify you have the needed dependencies and try again."
 
 else        
    echo "Success. WineASIO is now ready for use in $WINEPREFIX"

    # Cleanup TMP folder
    rm $POL_USER_ROOT/tmp/wineasio.dll.so
 
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlTCoAIACgkQ5TH6yaoTykf5bQCeJpSNDjv0TdR4U1gCWCNSIv+6
/T4Aniz72WwB8iPNbGrW6AgHT5r3bt2I
=+UD0
-----END PGP SIGNATURE-----
