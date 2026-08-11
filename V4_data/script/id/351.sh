#!/bin/bash
# Date : (see changelog)
# Last revision : (see changelog)
# Wine version used : 1.2, 1.3.9, 1.3.23, 1.4
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2010-02-09 12-00)
#   Initial writting.
# [GNU_Raziel] (2012-05-09 19:55)
#   Updates.
# [Dadu042] (2019-05-15 22-40)
#   Upgrade Wine 1.4 to 2.22 (after having read appdb.winehq.org). Move 'NoCD warning'.
# [Dadu042] (2020-04-06 14-00)
#   Wine 2.22 -> 3.0.3 (because I have the 'little window issue', OS Kubuntu 18.04 amd64).
#   Add code to support the demo.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Far Cry 2"
PREFIX="FarCry2"
EDITOR="Ubisoft"
GAME_URL="http://www.farcrygame.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
  
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/FarCry2/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TTILE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Game protection warning
POL_Call POL_Function_NoCDWarning
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
  
#Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="19900"
fi
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_gdiplus
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
## Fix for this game
POL_Wine_Direct3D "OffscreenRenderingMode" "pbuffer"
  
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
   
# Starting installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
  
# Making Shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
            
        POL_SetupWindow_menu "$(eval_gettext 'Are you installing the full game or the demo ?')" "$TITLE" "$(eval_gettext 'Full game')~$(eval_gettext 'Demo')" "~"      
         
        if [ "$APP_ANSWER" == "$(eval_gettext 'Full game')" ]; then
            POL_Shortcut "FC2Launcher.exe" "$TITLE" "$TITLE.png" "" "Game;"
        else
            POL_Shortcut "FarCry.exe" "$TITLE" "$TITLE.png" "" "Game;"
        fi
fi
  
## BEGIN Configurator
if [ ! -e "$POL_USER_ROOT/configurations/configurators/" ]; then
    mkdir -p "$POL_USER_ROOT/configurations/configurators/"
fi
   
cat << EOF1 > "$POL_USER_ROOT/configurations/configurators/Far Cry 2"
#!/bin/bash
  
[ "\$PLAYONLINUX" = "" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
   
TITLE="Far Cry 2"
PREFIX="FarCry2"
   
POL_SetupWindow_checkexist()
{        
        if [ ! -e \$POL_USER_ROOT/wineprefix/\$1 ]; then
                POL_SetupWindow_message "\$(eval_gettext 'Game is not installed')" "\$TITLE"
                exit 0
        fi
}
   
POL_SetupWindow_Init
POL_SetupWindow_checkexist "\$PREFIX"
   
POL_SetupWindow_message "\$(eval_gettext 'Welcome in \$TITLE configuration utils')" "\$TITLE"
   
POL_SetupWindow_message "\$(eval_gettext 'This utils only change game resolution.\nAll other settings will be set to default')" "\$TITLE"
   
GEOMETRY_SETTING="high"
   
POL_SetupWindow_menu_list "\$(eval_gettext 'Choose the game resolution you want')" "\$TITLE" "720x480-800x600-1024x768-1280x720-1280x768-1440x900" "-" "1024x768"
SELECTED_RES="\$APP_ANSWER"
   
if [ "\$SELECTED_RES" == "720x480" ];then
        ResX="720"
        ResY="480"
elif [ "\$SELECTED_RES" == "800x600" ];then
        ResX="800"
        ResY="600"
elif [ "\$SELECTED_RES" == "1024x768" ];then
        ResX="1024"
        ResY="768"
elif [ "\$SELECTED_RES" == "1280x720" ];then
        ResX="1280"
        ResY="720"
elif [ "\$SELECTED_RES" == "1280x768" ];then
        ResX="1280"
        ResY="768"
elif [ "\$SELECTED_RES" == "1440x900" ];then
        ResX="1440"
        ResY="900"
else
        ResX="1024"
        ResY="768"
fi
   
if [ ! -e "\$HOME/My Games/Far Cry 2/GamerProfile.xml" ]; then
        mkdir -p "\$HOME/My Games/Far Cry 2/"
else
        rm "\$HOME/My Games/Far Cry 2/GamerProfile.xml"
fi
   
cat << EOF2 > "\$HOME/My Games/Far Cry 2/GamerProfile.xml"
<GamerProfile>
        <SoundProfile MusicEnabled="1" MasterVolume="100" />
        <RenderProfile MultiSampleMode="0" AlphaToCoverage="0" ResolutionX="\$ResX" ResolutionY="\$ResY" Quality="custom" Fullscreen="1" Maximized="0" ForceWidescreen="0" AspectRatio="0" VSync="0" RefreshRate="60" DisableMip0Loading="0" MaxDriverBufferedFrames="0" Platform="d3d9" ShowFPS="0" ClustersZPassMaxLOD="1" Brightness="1" Contrast="1" GammaRamp="1" GammaRampR="1" GammaRampG="1" GammaRampB="1" AllowAsynchShaderLoading="1">
                <CustomQuality>
                        <quality ResolutionX="\$ResX" ResolutionY="\$ResY" EnvironmentQuality="low" AntiPortalQuality="high" PostFxQuality="low" TextureQuality="low" TextureResolutionQuality="low" WaterQuality="low" DepthPassQuality="high" VegetationQuality="low" TerrainQuality="low" GeometryQuality="\$GEOMETRY_SETTING" AmbientQuality="low" ShadowQuality="off" Hdr="0" HdrFP32="0" Bloom="0" id="custom" />
                        <quality ResolutionX="\$ResX" ResolutionY="\$ResY" EnvironmentQuality="high" AntiPortalQuality="high" PostFxQuality="high" TextureQuality="high" TextureResolutionQuality="high" WaterQuality="high" DepthPassQuality="high" VegetationQuality="high" TerrainQuality="high" GeometryQuality="\$GEOMETRY_SETTING" AmbientQuality="high" ShadowQuality="high" Hdr="1" HdrFP32="1" Bloom="1" id="customd3d10" />
                </CustomQuality>
        </RenderProfile>
        <NetworkProfile CustomMapMaxUploadRateOnline="10240" OnlineEnginePort="9000" OnlineServicePort="9001" FileTransferHostPort="9002" FileTransferClientPort="9003" LanBroadcastPort="9004" ScanFreePorts="1" ScanPortRange="1000" ScanPortStart="9000" SessionProvider="" DetectPublicAddress="1" MaxUploadOnline="768">
                <Accounts />
        </NetworkProfile>
        <GameProfile Sensitivity="1" Invert_y="0" UseMouseSmooth="0" Smoothness="0" Smoothness_Ironsight="1" HelpCrosshair="1" UseCompassMiniMap="1" UseRoadSignHilight="1" UseSubtitles="1" UseAmbx="0" Autosave="1" Machete="0" DifficultyLevel="1">
                <FireConfig QualitySetting="Low" />
        </GameProfile>
        <RealTreeProfile Quality="Low">
                <CustomQuality />
        </RealTreeProfile>
        <EngineProfile>
                <PhysicConfig QualitySetting="Low" />
                <QcConfig GatherFPS="1" GatherAICnt="1" IsQcTester="0" />
                <InputConfig />
        </EngineProfile>
</GamerProfile>
EOF2
   
POL_SetupWindow_Close
exit 0
EOF1
## End Configurator
  
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXos1uQAKCRDlMfrJqhPK
R/suAJ4oEiuYfwFEPwoXxsbOaqqRs/YxVACgkbCatXLssfdzDJ43vjWcEIkN9GE=
=zBxw
-----END PGP SIGNATURE-----
