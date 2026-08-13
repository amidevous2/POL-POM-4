#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

# Traductions
if [ "$POL_LANG" == "fr" ];
then 
	installation="Installation en cours"
	fin_texte="Merci de ne pas activer la vidéo d'introduction dans les options de jeux sans quoi il plantera au lancement"
	fin_titre="Installation terminée"
else 
	installation="Installation underway"
	fin_texte="Please do not activate the video introduction into the options game otherwise it will plant at launch"
	fin_titre="Installation complete"
fi 

# Presentation
wget http://upload.wikimedia.org/wikipedia/en/thumb/8/82/Tom_Clancy%27s_Ghost_Recon.jpg/256px-Tom_Clancy%27s_Ghost_Recon.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "Tom Clancy's Ghost Recon" "UbiSoft" "http://www.ghostrecon.com" "WarsTime" "GhostRecon"

# Vérification du CD
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

# Préparation de Wine
select_prefixe "$REPERTOIRE/wineprefix/GhostRecon"
POL_SetupWindow_prefixcreate
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s $CDROM ./d:

# Installation du jeu
POL_SetupWindow_wait_next_signal "$installation" "Ghost Recon"
wine $CDROM/setup.exe
POL_SetupWindow_detect_exit

# Mise en place du fichier options.xml permettant le lancement du jeu (intro désactivée)
cd $WINEPREFIX/drive_c/Program\ Files/Red\ Storm\ Entertainment/Ghost\ Recon/
> options.xml
echo '<OptionsFile>' >> options.xml;
echo '	<MouseRadiansPerPixel>0.008727</MouseRadiansPerPixel>' >> options.xml;
echo '	<UseMouseInput>TRUE</UseMouseInput>' >> options.xml;
echo '	<MoveShuffleThreshold>10</MoveShuffleThreshold>' >> options.xml;
echo '	<MoveNormalThreshold>30</MoveNormalThreshold>' >> options.xml;
echo '	<MoveFastThreshold>100</MoveFastThreshold>' >> options.xml;
echo '	<MouseLookReverseY>FALSE</MouseLookReverseY>' >> options.xml;
echo '	<ThreatIndicatorEnabled>TRUE</ThreatIndicatorEnabled>' >> options.xml;
echo '	<DefaultKeyMappingFilename>defplayr.keys</DefaultKeyMappingFilename>' >> options.xml;
echo '	<Gameplay>' >> options.xml;
echo '		<BloodOn>TRUE</BloodOn>' >> options.xml;
echo '		<RecordGame>TRUE</RecordGame>' >> options.xml;
echo '		<ShowIntro>FALSE</ShowIntro>' >> options.xml;
echo '		<AutoAssignStats>TRUE</AutoAssignStats>' >> options.xml;
echo '		<InitialRateOfFire>SINGLE</InitialRateOfFire>' >> options.xml;
echo '		<AlwaysRun>FALSE</AlwaysRun>' >> options.xml;
echo '		<ScaleCommandMap>TRUE</ScaleCommandMap>' >> options.xml;
echo '		<ScaleHUD>FALSE</ScaleHUD>' >> options.xml;
echo '		<IFFType>RETICULE</IFFType>' >> options.xml;
echo '	</Gameplay>' >> options.xml;
echo '	<ShellBackgroundIndex>1</ShellBackgroundIndex>' >> options.xml;
echo '	<ReticuleColorR>255</ReticuleColorR>' >> options.xml;
echo '	<ReticuleColorG>214</ReticuleColorG>' >> options.xml;
echo '	<ReticuleColorB>17</ReticuleColorB>' >> options.xml;
echo '	<ReticuleIFFColorR>160</ReticuleIFFColorR>' >> options.xml;
echo '	<ReticuleIFFColorG>200</ReticuleIFFColorG>' >> options.xml;
echo '	<ReticuleIFFColorB>255</ReticuleIFFColorB>' >> options.xml;
echo '	<XBoxMode>FALSE</XBoxMode>' >> options.xml;
echo '	<Graphics>' >> options.xml;
echo '		<FullScreen>TRUE</FullScreen>' >> options.xml;
echo '		<VideoResolution Width = "640" Height = "480" BitDepth = "16"/>' >> options.xml;
echo '		<ShowFrameRate>FALSE</ShowFrameRate>' >> options.xml;
echo '		<UsePrimaryDisplay>FALSE</UsePrimaryDisplay>' >> options.xml;
echo '		<UseDisplayDeviceGuid>FALSE</UseDisplayDeviceGuid>' >> options.xml;
echo '		<DisplayDeviceGuid>{76697264-5f65-5c63-5072-6f6772616d20}</DisplayDeviceGuid>' >> options.xml;
echo '		<CompressTextures>TRUE</CompressTextures>' >> options.xml;
echo '		<HumanShadowDetail>1</HumanShadowDetail>' >> options.xml;
echo '		<VehicleShadowDetail>1</VehicleShadowDetail>' >> options.xml;
echo '		<BulletHoleMax>100</BulletHoleMax>' >> options.xml;
echo '		<Gamma>0.500000</Gamma>' >> options.xml;
echo '		<DefaultMipMapping>FALSE</DefaultMipMapping>' >> options.xml;
echo '		<MipMapLODBias>-0.500000</MipMapLODBias>' >> options.xml;
echo '		<ShowDeadBodies>TRUE</ShowDeadBodies>' >> options.xml;
echo '		<CharVertexWeight>TRUE</CharVertexWeight>' >> options.xml;
echo '		<ParticleDetail>2</ParticleDetail>' >> options.xml;
echo '		<UITextureDetail>2</UITextureDetail>' >> options.xml;
echo '		<LevelTextureDetail>2</LevelTextureDetail>' >> options.xml;
echo '		<CharacterTextureDetail>2</CharacterTextureDetail>' >> options.xml;
echo '		<EffectTextureDetail>2</EffectTextureDetail>' >> options.xml;
echo '		<ZBufferBits>16</ZBufferBits>' >> options.xml;
echo '		<TreeModelDetail>HIGH</TreeModelDetail>' >> options.xml;
echo '		<CharacterModelDetail>HIGH</CharacterModelDetail>' >> options.xml;
echo '	</Graphics>' >> options.xml;
echo '	<Sound>' >> options.xml;
echo '		<MasterVolume>1.000000</MasterVolume>' >> options.xml;
echo '		<MasterSwitch>TRUE</MasterSwitch>' >> options.xml;
echo '		<EffectsVolume>1.000000</EffectsVolume>' >> options.xml;
echo '		<EffectsSwitch>TRUE</EffectsSwitch>' >> options.xml;
echo '		<MusicVolume>1.000000</MusicVolume>' >> options.xml;
echo '		<MusicSwitch>TRUE</MusicSwitch>' >> options.xml;
echo '		<VoiceVolume>1.000000</VoiceVolume>' >> options.xml;
echo '		<VoiceSwitch>TRUE</VoiceSwitch>' >> options.xml;
echo '		<AlternateCache>FALSE</AlternateCache>' >> options.xml;
echo '		<UseEAX>TRUE</UseEAX>' >> options.xml;
echo '		<SoundInSoftware>FALSE</SoundInSoftware>' >> options.xml;
echo '		<ChatIndicatorSound>FALSE</ChatIndicatorSound>' >> options.xml;
echo '	</Sound>' >> options.xml;
echo '	<Multiplayer>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<ChatMsg text = "" team = "false"/>' >> options.xml;
echo '		<MPGameName>---</MPGameName>' >> options.xml;
echo '		<MOTD>---</MOTD>' >> options.xml;
echo '		<JoinPort>2346</JoinPort>' >> options.xml;
echo '		<AnnouncePort>2347</AnnouncePort>' >> options.xml;
echo '		<BehindFirewall>FALSE</BehindFirewall>' >> options.xml;
echo '		<PreferredIP>PAR DEFAUT</PreferredIP>' >> options.xml;
echo '		<RemoteServerAccess>FALSE</RemoteServerAccess>' >> options.xml;
echo '		<RemoteServerPasswd/>' >> options.xml;
echo '		<GameSynchTimeout>600.000000</GameSynchTimeout>' >> options.xml;
echo '		<CharIndex>0</CharIndex>' >> options.xml;
echo '		<KitIndex>0</KitIndex>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '		<IPAddress/>' >> options.xml;
echo '	</Multiplayer>' >> options.xml;
echo '	<PlayerName>defPlayr</PlayerName>' >> options.xml;
echo '</OptionsFile>' >> options.xml;
< options.xml

# Configuration de Wine
Set_OS win95
Set_SoundDriver oss
Set_WineVersion_Assign 0.9.38 GhostRecon

POL_SetupWindow_reboot

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_make_shortcut "GhostRecon" "$PROGRAMFILES/Red Storm Entertainment/Ghost Recon" "GhostRecon.exe" "" "GhostRecon"

POL_SetupWindow_message "$fin_texte" "$fin_titre"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEcACgkQ5TH6yaoTykflmwCgoiNkl0hAuQU3Y4SOoZqJLQ2M
v7gAnj/DAxxEDYV2r1uZs/odSmibZHkV
=cA21
-----END PGP SIGNATURE-----
