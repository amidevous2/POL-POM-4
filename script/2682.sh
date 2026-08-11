#!/bin/bash
# Date : (2015-12-07 06-36)
# Last revision : (2015-12-19 18-28)
# Distribution used to test : Debian Sid (Unstable)
# Author : Gabriel Huber huberg18@gmail.com
# Script licence : GPL v.2

local INSTALLER_FILE="$1"
local TEMP_DIR="$2"
local INSTALL_PATH="$3"
local ADDITIONAL_ARGS="$4"

if [ ! "$INSTALLER_FILE" ]; then
    POL_Debug_Fatal "$(eval_gettext 'POL_innoextract failed: INSTALLER_FILE not set.')"
fi
if [ ! "$TEMP_DIR" ]; then
    POL_Debug_Fatal "$(eval_gettext 'POL_innoextract failed: TEMP_DIR not set.')"
fi
if [ ! "$INSTALL_PATH" ]; then
    POL_Debug_Fatal "$(eval_gettext 'POL_innoextract failed: INSTALL_PATH not set.')"
fi

# Check if we have innoextract
innoextract --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    POL_Debug_Fatal "$(eval_gettext 'Could not find innoextract binary. Install the "innoextract" package or see http://constexpr.org/innoextract for more information on how to install, then run the script again.')"
else
    POL_Debug_Message "Found innoextract"
fi

POL_SetupWindow_pulsebar "$(eval_gettext 'Extracting game files...')" "$TITLE"

# Extract installer data
local INNO_LOGFILE="${TEMP_DIR}/innoextract.log"
local LAST_PERCENTAGE="0"
# Fix return code for piped commands
set -o pipefail
# -e = extract, -q = quiet, -c = no color, -p = enable progress bar,
# -d = output directory
innoextract -e -q -c 0 -p 1 -d $ADDITIONAL_ARGS "$TEMP_DIR" \
        "$INSTALLER_FILE" 2>&1 | \
        tee "$INNO_LOGFILE" | \
        while read -d $'\r' input; do
    PERCENTAGE="$(echo "$input" | grep -o -P '\d+(?=\.\d+%)')"
    if [ "$PERCENTAGE" ] && [ "$PERCENTAGE" -ne "$LAST_PERCENTAGE" ]; then
        # Wait for the last pulse update to finish, so we don't spawn
        # too many processes
        wait
        # Run the command asyncronously because it takes about 300ms to finish
        POL_SetupWindow_pulse "$PERCENTAGE" &
        LAST_PERCENTAGE="$PERCENTAGE"
    fi
done

# Check return code of innoextract and show the logfile if it failed
if [ $? -ne 0 ]; then
   POL_SetupWindow_file "$(eval_gettext 'Failed to extract files. Is innoextract is up to date and the input file valid?')" "$TITLE" "$INNO_LOGFILE"
   POL_SetupWindow_Close
   exit $EXIT_ERROR
fi

# Some applications can have files with leading whitespace, which gets ignored
# by the installer. If you find a case where this is intentional, please
# notify me.

# Find files with leading whitespace characters
find "${TEMP_DIR}/app" -name " *" -print0 | \
        while read -d $'\0' FILENAME; do
    BASE="$(basename "$FILENAME")"
    DIR="$(dirname "$FILENAME")"
    # Replace leading whitespace with nothing
    BASE_TRIM="$(echo "$BASE" | sed -e 's/^ *//')"

    # Rename the file
    mv "$FILENAME" "${DIR}/${BASE_TRIM}"
done

# Remove the install folder if it exists
if [ -e "$INSTALL_PATH" ]; then
    rm -r "$INSTALL_PATH"
fi
# Make sure parent directory exists
mkdir -p "$(dirname "$INSTALL_PATH")"
# Move the app folder
mv "${TEMP_DIR}/app" "$INSTALL_PATH"

POL_Debug_Message "${INSTALLER_FILE} successfully installed to ${INSTALL_PATH}"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaIhOkACgkQ5TH6yaoTykdIxACePM8hyWfdO1vzJjYjI3A6oI8h
dK4AnRcGnvDH9SDodF9z/h4oLBIBVdqi
=bRP1
-----END PGP SIGNATURE-----
