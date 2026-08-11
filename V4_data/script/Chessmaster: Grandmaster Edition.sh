#!/usr/bin/env playonlinux-bash
# Date : (2015-07-07 13-33)
# Last revision : (2016-01-03 10-09)
# Wine version used : 1.6.2 (amd64)
# Distribution used to test : Linux Mint 17.2 KDE 64-bit
# Author : Justinian
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Chessmaster: Grandmaster Edition"
PREFIX="ChessmasterGrandmasterEdition"
NEEDED=4.2.0

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2712
POL_AdvisedVersion $NEEDED || POL_Debug_Message "$TITLE works better with $APPLICATION_TITLE $NEEDED\nPlease update"
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.ubi.com/" "Justinian" "$PREFIX"

# I had to split the following text into two seperate messages,
# as it would otherwise not fit in the window when displayed.
# I could have saved an extra line by replacing "Workaround:\n" with "Workaround: ",
# and that would have allowed the text to barely fit within the window.
# However, it is likely that the length of the text will change when translated to other languages,
# and would therefore not fit in the window for certain languages.
POL_SetupWindow_message "$(eval_gettext 'Known issues and workarounds:\n\n==== ISSUE 1 ====\nThe Ubisoft installation window sometimes stops responding during the installation.\n\nWorkaround:\nIf the Ubisoft installation window stops responding, then use $APPLICATION_TITLE to select "Tools" -> "Close all $APPLICATION_TITLE software". Then restart the installation.')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'Known issues and workarounds:\n\n==== ISSUE 2 ====\nWhen browsing the tutorials in $TITLE, the navigation buttons to the left of the tutorials do not work.\n\nWorkaround:\nDuring the installation, $APPLICATION_TITLE will automatically patch $TITLE so that all tutorials can be accessed without using the broken navigation buttons. The navigation buttons will still be broken, but you will have no need to use them.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Chessmaster Grandmaster Edition En/Chessmaster Grandmaster Edition.msi"

POL_Wine_SelectPrefix "$PREFIX"
# Chessmaster Grandmaster Edition's chess engine is available as both 32-bit and 64-bit executables.
# Presumably, the 64-bit executable should offer better performance.
# As such, PlayOnLinux should use a 64-bit Wine prefix if possible.
POL_System_SetArch "auto"
POL_Wine_PrefixCreate

POL_Wine start /unix "$CDROM/Autorun.exe"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

POL_Shortcut "gu.exe" "Chessmaster Grandmaster Edition" "$TITLE.png" "" "Game;BoardGame;KidsGame"
POL_Shortcut_Document "Chessmaster Grandmaster Edition" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Chessmaster® Grandmaster Edition Manual.pdf"

POL_System_TmpCreate "$PREFIX"

# Temporarily rename tutorials with identical names,
# so that they do not conflict when copied into the same folder.
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Arsenal/Mastery Quiz.tut" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Arsenal/Arsenal - Mastery Quiz.tut"
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Strategy/Mastery Quiz.tut" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Strategy/Strategy - Mastery Quiz.tut"

# Copy all tutorials into folders that are accessible without
# using Chessmaster: Grandmaster Edition's navigation buttons
# (since these buttons are broken in Wine).
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Intermediate/bruce diagnostic/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Intermediate/Tutorials/"
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Intermediate/Endgame Quiz/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Intermediate/Tutorials/"
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Advanced/Puzzles/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/Advanced/Match the masters/"
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Arsenal/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Intro/"
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Art of Learning/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Intro/"
cp -r "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Strategy/." "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Intro/"

# Change the names of the original tutorial files back to their original names.
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Arsenal/Arsenal - Mastery Quiz.tut" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Arsenal/Mastery Quiz.tut"
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Strategy/Strategy - Mastery Quiz.tut" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/Tutorials/josh academy/Josh Strategy/Mastery Quiz.tut"

# The "Curriculum.dat" file tells Chessmaster: Grandmaster Edition where its tutorial files are located.
# Since we have copied many of the tutorial files into new locations,
# we need to patch the default "Curriculum.dat" file to recognise these new locations.
# Furthermore, it would be nice to keep a backup of the existing "Curriculum.dat" file.
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/TData/Curriculum.dat" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/TData/Curriculum.dat.old"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/TData/Curriculum.dat.old" "$POL_System_TmpDir/Curriculum.dat.old"
cd "$POL_System_TmpDir"

# Extract lines that need to be converted into headers from "Curriculum.dat.old".
sed -n 14p Curriculum.dat.old > headers1.txt	# Beginning -> Tutorials
sed -n 158p Curriculum.dat.old >> headers1.txt	# Beginning -> Drills
sed -n 214p Curriculum.dat.old >> headers1.txt	# Intermediate -> Tutorials
sed -n 256p Curriculum.dat.old >> headers1.txt	# Intermediate -> Drills
sed -n 301p Curriculum.dat.old >> headers1.txt	# Intermediate -> Larry Evans' Endgame Quiz
sed -n 270p Curriculum.dat.old >> headers1.txt	# Intermediate -> Rating Exam
sed -n 306p Curriculum.dat.old >> headers1.txt	# Advanced -> Match the Masters
sed -n 379p Curriculum.dat.old >> headers1.txt	# Advanced -> Drills
sed -n 321p Curriculum.dat.old >> headers1.txt	# Advanced -> Nunn's Puzzles
sed -n 399p Curriculum.dat.old >> headers1.txt	# Kids -> Tutorials
sed -n 542p Curriculum.dat.old >> headers1.txt	# Kids -> Drills
sed -n 598p Curriculum.dat.old >> headers1.txt	# Kids -> Josh Games
sed -n 699p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Introduction
sed -n 728p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Arsenal
sed -n 742p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Strategy
sed -n 804p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> The Art of Learning
sed -n 855p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Endgame Course
sed -n 756p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Psychology of Competition
sed -n 788p Curriculum.dat.old >> headers1.txt	# Josh Waitzkin's Academy -> Annotated Games
sed -n 892p Curriculum.dat.old >> headers1.txt	# Larry Christiansen Attacking Chess -> Attacking Chess
sed -n 908p Curriculum.dat.old >> headers1.txt	# Larry Christiansen Attacking Chess -> Christiansen vs Chessmaster

# Convert the extracted lines into headers, by adding the appropriate suffix to each line.
sed 's/\r/,HEADER,0\r/' headers1.txt > headers2.txt

# Indent the headers appropriately.
sed 's/^/\t/' headers2.txt > headers.txt

# At various points during the construction of the new "Curriculum.dat" file,
# it will be necessary to add the following strings:
# "\t{\r\n", "\t}\r\n" and "\t}\r\n\t\r\n".
# Rather than repeatedly reconstructing these strings,
# it is better to construct them once, store them in files and reuse them.
cat << EOF >> open1.txt
	{
EOF
sed 's/$/\r/' open1.txt > open.txt
cat << EOF >> close1.txt
	}
EOF
sed 's/$/\r/' close1.txt > close.txt
cat << EOF >> close_line1.txt
	}
	
EOF
sed 's/$/\r/' close_line1.txt > close_line.txt

# Construct the new "Curriculum.dat" file.
# 
# Sections of "Curriculum.dat.old" that do not need to be modified can be copied as is,
# using a single sed command.
# 
# However, each section that needs to be modified requires a block of 5 commands.
# These command blocks are structured as follows:
# "sed" to get the appropriate header line from "headers.txt"
# "cat" to get an opening brace from "open.txt"
# "sed" to get the content for the current block from "Curriculum.dat.old"
# "sed" to indent the content obtained in the previous step (sometimes this requires 1 tab, other times it requires 2 tabs)
# "cat" to get a closing brace (either from "close.txt" or "close_line.txt", depending on whether a trailing newline is required)

sed -n 1,15p Curriculum.dat.old > Curriculum.dat

# Beginning -> Tutorials
sed -n 1p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 17,154p Curriculum.dat.old > B-T.txt
sed 's/^/\t\t/' B-T.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Beginning -> Drills
sed -n 2p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 160,211p Curriculum.dat.old > B-D.txt
sed 's/^/\t/' B-D.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 156,215p Curriculum.dat.old >> Curriculum.dat

# Intermediate -> Tutorials
sed -n 3p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 217,247p Curriculum.dat.old > I-T.txt
sed 's/^/\t\t/' I-T.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Intermediate -> Drills
sed -n 4p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 258,267p Curriculum.dat.old > I-D.txt
sed 's/^/\t/' I-D.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Intermediate -> Larry Evans' Endgame Quiz
sed -n 5p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 303p Curriculum.dat.old > I-L.txt
sed 's/^/\t/' I-L.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Intermediate -> Rating Exam
sed -n 6p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 272,298p Curriculum.dat.old > I-R.txt
sed 's/^/\t/' I-R.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 249,307p Curriculum.dat.old >> Curriculum.dat

# Advanced -> Match the Masters
sed -n 7p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 308,318p Curriculum.dat.old > A-M.txt
sed 's/^/\t/' A-M.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Advanced -> Drills
sed -n 8p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 381,396p Curriculum.dat.old > A-D.txt
sed 's/^/\t/' A-D.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Advanced -> Nunn's Puzzles
sed -n 9p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 323,376p Curriculum.dat.old > A-N.txt
sed 's/^/\t/' A-N.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 319,400p Curriculum.dat.old >> Curriculum.dat

# Kids -> Tutorials
sed -n 10p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 401,538p Curriculum.dat.old > K-T.txt
sed 's/^/\t\t/' K-T.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Kids -> Drills
sed -n 11p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 544,595p Curriculum.dat.old > K-D.txt
sed 's/^/\t/' K-D.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Kids -> Josh Games
sed -n 12p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 600,611p Curriculum.dat.old > K-J.txt
sed 's/^/\t/' K-J.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 540,700p Curriculum.dat.old >> Curriculum.dat

# Josh Waitzkin's Academy -> Introduction
sed -n 13p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 701,722p Curriculum.dat.old > J-I.txt
sed 's/^/\t/' J-I.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# "Josh Waitzkin's Academy -> Arsenal" and "Josh Waitzkin's Academy -> Strategy" present special cases.
# Earlier in the script, tutorials from these categories were renamed,
# so that their filenames did not conflict when the files were copied into the same folder.
# As such, the "Curriculum.dat" file needs to be modified to recognise the new filenames.

# Josh Waitzkin's Academy -> Arsenal
sed -n 14p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 730,737p Curriculum.dat.old > J-A.txt
sed -n 738p Curriculum.dat.old > J-A_tmp.txt
sed 's/\t/\tArsenal - /' J-A_tmp.txt >> J-A.txt
sed -n 739p Curriculum.dat.old >> J-A.txt
sed 's/^/\t/' J-A.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Josh Waitzkin's Academy -> Strategy
sed -n 15p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 744,751p Curriculum.dat.old > J-S.txt
sed -n 752p Curriculum.dat.old > J-S_tmp.txt
sed 's/\t/\tStrategy - /' J-S_tmp.txt >> J-S.txt
sed -n 753p Curriculum.dat.old >> J-S.txt
sed 's/^/\t/' J-S.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Josh Waitzkin's Academy -> The Art of Learning
sed -n 16p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 806,852p Curriculum.dat.old > J-T.txt
sed 's/^/\t/' J-T.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Josh Waitzkin's Academy -> Endgame Course
sed -n 17p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 857,889p Curriculum.dat.old > J-E.txt
sed 's/^/\t/' J-E.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Josh Waitzkin's Academy -> Psychology of Competition
sed -n 18p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 758,785p Curriculum.dat.old > J-P.txt
sed 's/^/\t/' J-P.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Josh Waitzkin's Academy -> Annotated Games
sed -n 19p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 790,801p Curriculum.dat.old > J-G.txt
sed 's/^/\t/' J-G.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 723,893p Curriculum.dat.old >> Curriculum.dat

# Larry Christiansen Attacking Chess -> Attacking Chess
sed -n 20p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 894,904p Curriculum.dat.old > L-A.txt
sed 's/^/\t/' L-A.txt >> Curriculum.dat
cat close_line.txt >> Curriculum.dat

# Larry Christiansen Attacking Chess -> Christiansen vs Chessmaster
sed -n 21p headers.txt >> Curriculum.dat
cat open.txt >> Curriculum.dat
sed -n 910,916p Curriculum.dat.old > L-C.txt
sed 's/^/\t/' L-C.txt >> Curriculum.dat
cat close.txt >> Curriculum.dat

sed -n 906,918p Curriculum.dat.old >> Curriculum.dat

# Copy the new "Curriculum.dat" file to the appropriate location.
cp "$POL_System_TmpDir/Curriculum.dat" "$WINEPREFIX/drive_c/$PROGRAMFILES/Ubisoft/Chessmaster Grandmaster Edition/Data/TData/Curriculum.dat"

POL_System_TmpDelete

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAladRBYACgkQ5TH6yaoTykfdRgCfVJ04mJEWg1v0NTtHfAP/0WxR
SnkAn3xWz3xFWiD0tIB7v66+ds+olepo
=ltTf
-----END PGP SIGNATURE-----
