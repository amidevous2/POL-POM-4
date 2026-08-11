 
# Create the setup window
POL_SetupWindow_Init
 
# Required
POL_Debug_Init
 
# Set up the initial page
POL_SetupWindow_presentation "$TITLE" "PatternMaker Software" "http://www.patternmakerusa.com" "Alex Elsayed" "$PREFIX"
 
# Test for a new enough Bash
# Fixes runtime error on OS X 10.6.8 (with Bash 3.2.48)
# Removed warnings since all versions of OSX use Bash < 4
if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    # POL_Debug_Error "This version of Bash doesn't support associative arrays, some functionality may not be usable"
    # POL_SetupWindow_message "$(eval_gettext "As your system has an old version of Bash, this script will be unable to install any patterns for you")" "$TITLE"
else
    declare -a PATTERNS_CHOSEN
    declare -A PATTERN_URLS
    declare -A PATTERN_DIGESTS
 
    PATTERN_URLS=(
        [Juniors]="http://www.patternmakerusa.com/downloads/Juniors_PM75.exe"
    [Coat/Robe]="http://www.patternmakerusa.com/downloads/CoatRobe_PM75.exe"
    [Womens Volume 1]="http://www.patternmakerusa.com/downloads/Women1_PM75.exe"
    [Super Jacket]="http://www.patternmakerusa.com/downloads/SuperJkt_PM75.exe"
    [Renaissance Corset]="http://www.patternmakerusa.com/downloads/Corset_PM75.exe"
    [Womens Volume 2]="http://www.patternmakerusa.com/downloads/Women2_PM75.exe"
    [Sportswear]="http://www.patternmakerusa.com/downloads/Sportswear_PM75.exe"
    [Dog Suit]="http://www.patternmakerusa.com/downloads/DogSuit_PM75.exe"
    [Lingerie]="http://www.patternmakerusa.com/downloads/Lingerie_PM75.exe"
    [Super Skirt]="http://www.patternmakerusa.com/downloads/SuperSkirt_PM75.exe"
    [Raglan]="http://www.patternmakerusa.com/downloads/Raglan_PM75.exe"
    [Basic Blocks]="http://www.patternmakerusa.com/downloads/Blocks_PM75.exe"
    [Super Pants]="http://www.patternmakerusa.com/downloads/SuperPants_PM75.exe"
    [Men]="http://www.patternmakerusa.com/downloads/Men_PM75.exe"
    )
    PATTERN_DIGESTS=(
        [Juniors]="af6b2608c2bd58cffc92240a155802ac"
    [Coat/Robe]="d7cf9812fc001c7734f9b136158acbbb"
    [Womens Volume 1]="6d51a3747dc00d28f6aedc02d067fb87"
    [Super Jacket]="bc3ed65c190967c1853e6fc14c67e936"
    [Renaissance Corset]="c3db9895a68d886d49100e9163377f12"
    [Womens Volume 2]="60317ea8e0d3e0dab742934ecb4abdf1"
    [Sportswear]="8134c599093a6efb41c826e30f2a7b29"
    [Dog Suit]="626c552d11535269f6c51a12984b2c2f"
    [Lingerie]="2f80a4a894b9fb69d64463bc43fb8841"
    [Super Skirt]="a1f176557b60eec95d065c57c0c17601"
    [Raglan]="29f906bf37243dd30cc8e6d02b0b52d8"
    [Basic Blocks]="cf740e237a4d557a9baf26a097fa6ecc"
    [Super Pants]="76be51f9f3eb2318deab5b008869b191"
    [Men]="4c63bec7897419aee20541f05695333e"
    )
 
    function prompt_patterns() {
        local IFS="~"
        POL_SetupWindow_checkbox_list "$(eval_gettext "What patterns would you like to install?")" "${TITLE}" "${!PATTERN_URLS[*]}" "~"
        PATTERNS_CHOSEN=( $APP_ANSWER )
    }
 
    # Ask which patterns they want
    prompt_patterns
fi
 
if [ -n $MACROTOOL_URL ]; then
    POL_SetupWindow_question "$(eval_gettext "Would you like to install the PatternMaker MacroGenerator?")" "$TITLE"
fi
if [ ${APP_ANSWER} == FALSE ]; then
    MACROTOOL_URL=""
fi
 
# Create a temporary directory we can use
POL_System_TmpCreate "${PREFIX}"
# ...and enter it
cd "${POL_System_TmpDir}"
 
# Install into the PatternMaker Wine environment
POL_Wine_SelectPrefix "${PREFIX}"
 
# Create the environment if it does not yet exist
POL_Wine_PrefixCreate
 
POL_SetupWindow_question "$(eval_gettext "Several installers will be downloaded, and may be beneficial to keep afterwards. Would you like to keep them?")" "$TITLE"
if [ ${APP_ANSWER} == FALSE ]; then
    DELETE_DOWNLOADS="1"
    POL_SetupWindow_message "$(eval_gettext "Understood. All downloaded files will be deleted when finished.")"
fi
 
POL_SetupWindow_message "$(eval_gettext "Downloading installers...")"
# Download the installer, verifying it against a digest
POL_Download_Resource "${INSTALLER_URL}" "${INSTALLER_DIGEST}" "${TITLE}"
if [ -n $MACROTOOL_URL ]; then
    POL_Download_Resource "${MACROTOOL_URL}" "${MACROTOOL_DIGEST}" "${TITLE}"
fi
if [ ${BASH_VERSINFO[0]} -ge 4 ]; then
    for pat in "${PATTERNS_CHOSEN[@]}"; do
        POL_Download_Resource "${PATTERN_URLS["${pat}"]}" "${PATTERN_DIGESTS["${pat}"]}" "${TITLE}"
    done
fi
 
# Apply a registry tweak to open PDF files in the native viewer
POL_Call POL_Function_SetNativeExtension "pdf"
 
# Run the installer
POL_Wine "${POL_USER_ROOT}/ressources/${TITLE}/$(basename "${INSTALLER_URL}")"
# And the macro installer
if [ -n $MACROTOOL_URL ]; then
    POL_Wine "${POL_USER_ROOT}/ressources/${TITLE}/$(basename "${MACROTOOL_URL}")"
fi
if [ ${BASH_VERSINFO[0]} -ge 4 ]; then
    # And the pattern installers
    for pat in "${PATTERNS_CHOSEN[@]}"; do
        POL_Wine "${POL_USER_ROOT}/ressources/${TITLE}/$(basename "${PATTERN_URLS["${pat}"]}")"
    done
fi
 
# Create a shortcut
POL_Shortcut "PatVer7_5.exe" "${TITLE}"
 
if [ -n $MACROTOOL_URL ]; then
     POL_Shortcut "MacroGen4_5.exe" "${TITLE} MacroGenerator"
fi
 
POL_SetupWindow_Close
 
# Clean up after ourselves
POL_System_TmpDelete
[ -n $DELETE_DOWNLOADS ] && rm -r "${POL_USER_ROOT}/ressources/${TITLE}"
 
# The script will be signed; prevent bash from trying
# to run the signature
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRg7CgAKCRDlMfrJqhPK
RyvCAJ48KZMDL7SUtWxWZF8VZVosrRQc3QCeMiE1A7qV3rSp8WCoTniOHdPKgAo=
=xeoK
-----END PGP SIGNATURE-----
