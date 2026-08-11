#!/bin/bash
# Date : (2011-11-27 19-47)
# Last revision : (2013-12-08 00-38)
# Wine version used : 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend : none

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="outcast"
PREFIX="Outcast_gog"
WORKING_WINE_VERSION="1.6.1"

TITLE="GOG.com - Outcast"
SHORTCUT_NAME="Outcast"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1013
# Older versions could shortcut start.exe from windows/command subdirectory
POL_RequiredVersion "4.1.2" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.2 is required to install $TITLE"

POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Appeal S.A. / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c588dab89cccaddfbcde2ebd69d5fad9"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# Main game will crash if desktop size is not constrained
Set_Desktop "On" "640" "480"

POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot 


POL_Shortcut "GOG Games/Outcast/LOADER.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Outcast/manual.pdf"
# C:\GOG Games\Outcast\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > $POL_USER_ROOT/configurations/configurators/"$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

TITLE="$TITLE"

cd "$GOGROOT/Outcast/" || exit 1

CURRENT_LANG="$(eval_gettext 'English')"
[ -f pol_configuration ] && source pol_configuration

POL_SetupWindow_Init

POL_SetupWindow_menu_list "$(eval_gettext 'Choose the game language you want')" "\$TITLE" "$(eval_gettext 'English')~$(eval_gettext 'French')~$(eval_gettext 'German')~$(eval_gettext 'Brasilian (text only)')~$(eval_gettext 'Dutch (text only)')~$(eval_gettext 'Italian (text only)')~$(eval_gettext 'Spanish (text only)')" "~" "\$CURRENT_LANG"
if [ "\$CURRENT_LANG" != "\$APP_ANSWER" ]; then
    CURRENT_LANG="\$APP_ANSWER"
    case "\$CURRENT_LANG" in
	"$(eval_gettext 'English')")
	    ln -sf Data/Voices/ENGLISH/FIX.PAK fix.pak
	    ln -sf Data/Voices/ENGLISH/TEXT.PAK text.pak
	    ln -sf Data/Voices/ENGLISH/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/ENGLISH/VOICESGE.PAK voicesgen+.pak
	    ;;
	"$(eval_gettext 'French')")
	    ln -sf Data/Voices/French/FIX.PAK fix.pak
	    ln -sf Data/Voices/French/TEXT.PAK text.pak
	    ln -sf Data/Voices/French/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/French/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/French/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/French/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/French/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/French/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/French/VOICESGE.PAK voicesgen+.pak
	    ;;
	"$(eval_gettext 'German')")
	    ln -sf Data/Voices/German/FIX.PAK fix.pak
	    ln -sf Data/Voices/German/TEXT.PAK text.pak
	    ln -sf Data/Voices/German/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/German/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/German/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/German/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/German/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/German/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/German/VOICESGE.PAK voicesgen+.pak
	    ;;
        "$(eval_gettext 'Brasilian (text only)')")
	    ln -sf Data/Voices/Brasilian/FIX.PAK fix.pak
	    ln -sf Data/Voices/Brasilian/TEXT.PAK text.pak
	    ln -sf Data/Voices/ENGLISH/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/ENGLISH/VOICESGE.PAK voicesgen+.pak
            ;;
        "$(eval_gettext 'Dutch (text only)')")
	    ln -sf Data/Voices/Dutch/FIX.PAK fix.pak
	    ln -sf Data/Voices/Dutch/TEXT.PAK text.pak
	    ln -sf Data/Voices/ENGLISH/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/ENGLISH/VOICESGE.PAK voicesgen+.pak
            ;;
        "$(eval_gettext 'Italian (text only)')")
	    ln -sf Data/Voices/Italian/FIX.PAK fix.pak
	    ln -sf Data/Voices/Italian/TEXT.PAK text.pak
	    ln -sf Data/Voices/ENGLISH/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/ENGLISH/VOICESGE.PAK voicesgen+.pak
            ;;
        "$(eval_gettext 'Spanish (text only)')")
	    ln -sf Data/Voices/Spanish/FIX.PAK fix.pak
	    ln -sf Data/Voices/Spanish/TEXT.PAK text.pak
	    ln -sf Data/Voices/ENGLISH/VOICES1.PAK voices1+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES2.PAK voices2+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES3.PAK voices3+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES4.PAK voices4+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES5.PAK voices5+.pak
	    ln -sf Data/Voices/ENGLISH/VOICES6.PAK voices6+.pak
	    ln -sf Data/Voices/ENGLISH/VOICESGE.PAK voicesgen+.pak
            ;;
    esac
fi

POL_SetupWindow_menu "$(eval_gettext 'Standard keyboard layouts')" "\$TITLE" "$(eval_gettext 'Unchanged')~$(eval_gettext 'Arrow keys (default)')~$(eval_gettext 'WASD (Qwerty)')~$(eval_gettext 'ZQSD (Azerty)')" "~" "$(eval_gettext 'Unchanged')"
case "\$APP_ANSWER" in
    "$(eval_gettext 'Unchanged')")
        ;;
    "$(eval_gettext 'Arrow keys (default)')")
        # LF -> CRLF mantra
        cat <<'_MAPEOF_' | sed 's/$'"/`echo \\\r`/" > Control.ini
[Trigger]
Slow=KEY_RALT     
Rudder_LeftRight=~MOUSE_AXIS_0 JOY_AXIS_3
RudderRight=JOYBUT7
RudderMotion=KEY_LALT     
RudderLeft=JOYBUT6
BackForward=JOY_AXIS_1
LeftRight=JOY_AXIS_0
CameraFar=||KEY_NUMPAD1 JOYBUT258 KEY_END
CameraNear=||KEY_NUMPAD7 JOYBUT256 KEY_HOME
Forward=|KEY_NUMPAD8 KEY_UP     
Backward=|KEY_NUMPAD2 KEY_DOWN     
Left=|KEY_NUMPAD4 KEY_LEFT     
Right=|KEY_NUMPAD6 KEY_RIGHT     
Fire=||MOUSE_BUTTON_0 JOYBUT0 KEY_LCONTROL
Target=||MOUSE_BUTTON_1 JOYBUT1 KEY_LSHIFT
MapZoomout=KEY_SUBTRACT     
MapZoomin=KEY_ADD     
MapToggleSize=KEY_MULTIPLY     
Map=KEY_TAB     
Inventory=|KEY_I JOYBUT6     
WeaponPrevious=KEY_NUMPAD3     
WeaponNext=KEY_NUMPAD9     
Weapon6=KEY_6     
Weapon5=KEY_5     
Weapon4=KEY_4     
Weapon3=KEY_3     
Weapon2=KEY_2     
Weapon1=KEY_1     
XRay=KEY_X     
PitchUp=|JOYBUT259 KEY_PAGEUP     
PitchDown=|JOYBUT257 KEY_PAGEDOWN     
Pitch=MOUSE_AXIS_1
Notepad=KEY_N     
BackPack=KEY_B     
Lexicon=KEY_L     
LockTarget=KEY_K     
ClearHands=KEY_0     
Abort=|KEY_ESCAPE JOYBUT1
Escape=KEY_ESCAPE
Crawl=|JOYBUT4 KEY_SPACE     
Jump=JOYBUT5
FirstPerson=|JOYBUT7 KEY_RCONTROL     
PitchAbsolute=JOY_AXIS_2
VolumeUp=KEY_R     
VolumeDown=KEY_E     
MouseUp=KEY_V     
MouseDown=KEY_C     
BalanceUp=KEY_F     
BalanceDown=KEY_D     
CameraRight=
CameraLeft=
disablejoystick=0

[Sensitivity]
MouseSensitivity=0.500000
InvertedMouse=-1.000000
swapmousebuttons=0

[Sound_Quality_Control]
3D_sound=1
EAX_support=1
_MAPEOF_
	;;
    "$(eval_gettext 'WASD (Qwerty)')")
        cat <<'_MAPEOF_' | sed 's/$'"/`echo \\\r`/" > Control.ini
[Trigger]
Slow=KEY_RALT
Rudder_LeftRight=~MOUSE_AXIS_0 JOY_AXIS_3
RudderRight=JOYBUT7
RudderMotion=KEY_LALT
RudderLeft=JOYBUT6
BackForward=JOY_AXIS_1
LeftRight=JOY_AXIS_0
CameraFar=||KEY_NUMPAD1 JOYBUT258 KEY_END
CameraNear=||KEY_NUMPAD7 JOYBUT256 KEY_HOME
Forward=||KEY_W KEY_NUMPAD8 KEY_UP
Backward=||KEY_S KEY_NUMPAD2 KEY_DOWN
Left=||KEY_A KEY_NUMPAD4 KEY_LEFT
Right=||KEY_D KEY_NUMPAD6 KEY_RIGHT
Fire=|MOUSE_BUTTON_0 KEY_LCONTROL
Target=||MOUSE_BUTTON_1 JOYBUT1 KEY_LSHIFT
MapZoomout=KEY_SUBTRACT
MapZoomin=KEY_ADD
MapToggleSize=KEY_MULTIPLY
Map=KEY_TAB
Inventory=|KEY_R JOYBUT6
WeaponPrevious=|KEY_NUMPAD3 KEY_Z
WeaponNext=|KEY_NUMPAD9 KEY_Q
Weapon6=KEY_6
Weapon5=KEY_5
Weapon4=KEY_4
Weapon3=KEY_3
Weapon2=KEY_2
Weapon1=KEY_1
XRay=KEY_X
PitchUp=|JOYBUT259 KEY_PAGEUP
PitchDown=|JOYBUT257 KEY_PAGEDOWN
Pitch=MOUSE_AXIS_1
Notepad=KEY_T
BackPack=KEY_B
Lexicon=KEY_L
LockTarget=KEY_E
ClearHands=|KEY_0 KEY_V
Abort=|KEY_ESCAPE JOYBUT1
Escape=KEY_ESCAPE
Crawl=||JOYBUT4 KEY_C KEY_SPACE
Jump=JOYBUT5
FirstPerson=||JOYBUT7 KEY_RCONTROL KEY_F
PitchAbsolute=JOY_AXIS_2
VolumeUp=KEY_U
VolumeDown=KEY_Y
MouseUp=KEY_I
MouseDown=KEY_K
BalanceUp=KEY_J
BalanceDown=KEY_H
CameraRight=
CameraLeft=
disablejoystick=0

[Sensitivity]
MouseSensitivity=0.500000
InvertedMouse=-1.000000
swapmousebuttons=0

[Sound_Quality_Control]
3D_sound=1
EAX_support=1
_MAPEOF_
	;;
    "$(eval_gettext 'ZQSD (Azerty)')")
        cat <<'_MAPEOF_' | sed 's/$'"/`echo \\\r`/" > Control.ini
[Trigger]
Slow=KEY_RALT
Rudder_LeftRight=~MOUSE_AXIS_0 JOY_AXIS_3
RudderRight=JOYBUT7
RudderMotion=KEY_LALT
RudderLeft=JOYBUT6
BackForward=JOY_AXIS_1
LeftRight=JOY_AXIS_0
CameraFar=||KEY_NUMPAD1 JOYBUT258 KEY_END
CameraNear=||KEY_NUMPAD7 JOYBUT256 KEY_HOME
Forward=||KEY_Z KEY_NUMPAD8 KEY_UP
Backward=||KEY_S KEY_NUMPAD2 KEY_DOWN
Left=||KEY_Q KEY_NUMPAD4 KEY_LEFT
Right=||KEY_D KEY_NUMPAD6 KEY_RIGHT
Fire=|MOUSE_BUTTON_0 KEY_LCONTROL
Target=||MOUSE_BUTTON_1 JOYBUT1 KEY_LSHIFT
MapZoomout=KEY_SUBTRACT
MapZoomin=KEY_ADD
MapToggleSize=KEY_MULTIPLY
Map=KEY_TAB
Inventory=|KEY_R JOYBUT6
WeaponPrevious=|KEY_NUMPAD3 KEY_W
WeaponNext=|KEY_NUMPAD9 KEY_A
Weapon6=KEY_6
Weapon5=KEY_5
Weapon4=KEY_4
Weapon3=KEY_3
Weapon2=KEY_2
Weapon1=KEY_1
XRay=KEY_X
PitchUp=|JOYBUT259 KEY_PAGEUP
PitchDown=|JOYBUT257 KEY_PAGEDOWN
Pitch=MOUSE_AXIS_1
Notepad=KEY_T
BackPack=KEY_B
Lexicon=KEY_L
LockTarget=KEY_E
ClearHands=|KEY_0 KEY_V
Abort=|KEY_ESCAPE JOYBUT1
Escape=KEY_ESCAPE
Crawl=||JOYBUT4 KEY_C KEY_SPACE
Jump=JOYBUT5
FirstPerson=||JOYBUT7 KEY_RCONTROL KEY_F
PitchAbsolute=JOY_AXIS_2
VolumeUp=KEY_U
VolumeDown=KEY_Y
MouseUp=KEY_I
MouseDown=KEY_K
BalanceUp=KEY_J
BalanceDown=KEY_H
CameraRight=
CameraLeft=
disablejoystick=0

[Sensitivity]
MouseSensitivity=0.500000
InvertedMouse=-1.000000
swapmousebuttons=0

[Sound_Quality_Control]
3D_sound=1
EAX_support=1
_MAPEOF_
	;;
esac

POL_SetupWindow_menu "$(eval_gettext 'Visual quality')" "\$TITLE" "$(eval_gettext 'Unchanged')~$(eval_gettext 'Factory defaults')~$(eval_gettext 'High quality (Entropy settings)')" "~" "$(eval_gettext 'Unchanged')"

case "\$APP_ANSWER" in
    "$(eval_gettext 'Unchanged')")
        ;;
    "$(eval_gettext 'Factory defaults')")
        cat <<'_INIEOF_' > antialiasing_high.ini 
[Visual_Quality_Control]
Global_Antialiasing= 1
Combat_Antialiasing = 3
Normal_Antialiasing = 3
Dialog_Antialiasing = 3

lnd_aa_level=2

lnd_bilinear_range=4.0
_INIEOF_
        cat <<'_INIEOF_' > DOC_high.ini 
[Visual_Quality_Control]
lnd_base_layers=0

[Render_Mesh]
temples_world_view_angle=35.000000
temples_world_view_dist=6000.000000
temples_world_far_view_angle=38.000000
temples_world_far_view_dist=9000

marais_world_view_angle=35.000000
marais_world_view_dist=5000.000000
marais_world_far_view_angle=38.000000
marais_world_far_view_dist=8000

montagne_world_view_angle=35.000000
montagne_world_view_dist=5500.000000
montagne_world_far_view_angle=38.000000
montagne_world_far_view_dist=8000

ville_world_view_angle=35.000000
ville_world_view_dist=5000.000000
ville_world_far_view_angle=38.000000
ville_world_far_view_dist=7000

foret_world_view_angle=35.000000
foret_world_view_dist=4500.000000
foret_world_far_view_angle=38.000000
foret_world_far_view_dist=9000

neige_world_view_angle=35.000000
neige_world_view_dist=5500.000000
neige_world_far_view_angle=38.000000
neige_world_far_view_dist=8500

neige2_world_view_angle=35.000000
neige2_world_view_dist=5500.000000
neige2_world_far_view_angle=38.000000
neige2_world_far_view_dist=8500


[Render__mesh]
temples__mesh_back_plane=5500
marais__mesh_back_plane=4500
montagne__mesh_back_plane=5000
ville__mesh_back_plane=4500
foret__mesh_back_plane=4000
neige__mesh_back_plane=5000
neige2__mesh_back_plane=5000

[Render_big_mesh]
temples_big_mesh_back_plane=8500
marais_big_mesh_back_plane=7500
montagne_big_mesh_back_plane=7500
ville_big_mesh_back_plane=6000
foret_big_mesh_back_plane=8000
neige_big_mesh_back_plane=7500
neige2_big_mesh_back_plane=7500

[Fog]
temples_fog_density=7
temples_fog_sky_scale=1
marches_fog_density=7
marches_fog_sky_scale=2
montagne_fog_density=6
montagne_fog_sky_scale=2
ville_fog_density=8
ville_fog_sky_scale=2
foret_fog_density=7
foret_fog_sky_scale=2
neige_fog_density=7
neige_fog_sky_scale=3
burned_fog_density=7
burned_fog_sky_scale=3
_INIEOF_
        cat <<'_INIEOF_' > object_detail_high.ini 
[Visual_Quality_Control]
highobjectdetail=1
global_particle_level=2

[Leaves]
MinimumLeaveSize=2
MaximumLeaveSize=2.5
NumberOfLeavesSmall=6
NumberOfLeavesBig=9
MipmapLevel2=1300.000000
MipmapLevel1=2700.000000

[Snow]
Whirl_speed_ratio=200.000000
Whirl_speed=20000.000000
Transition_multiplier_snow_trigger=2.000000
Transition_base_snow_trigger=-1.000000
Side_move_effect=20.000000
Radius_around_cutter=1500.000000
Position_above_cutter=1000.000000
Minimum_weight=5.000000
Minimum_scale=10.000000
Maximum_weight=10.000000
Maximum_scale=12.000000
Good_weather_in_frames=2000
Fog_basic_altitude=1300.000000
Flakes_number=1000
Down_fog_speed=2.000000
Down_fog_altitude=-600.000000
Bad_weather_in_frames=4000


_INIEOF_
        cat <<'_INIEOF_' > 'Pentium III 550+ 64 Mb.ini'
[performance]
resolution=400x300
cinemascope=false

crowdlevel=true
ambientsounds=true
bumpmapping=true
highanimationdetail=true

antialiasing=high
chardetail=high
objectdetail=high
prq=high
dof=med

doc=high
_INIEOF_
        cat <<'_INIEOF_' > character_detail_high.ini
[Visual_Quality_Control]
amh_shadow_limit_contraction_factor=1.5
amh_bump_disable_distance=1800

combat_stan_lod_near_limit=450.0
combat_stan_lod_far_limit=800.0
normal_stan_lod_near_limit=450.0
normal_stan_lod_far_limit=800.0
dialog_stan_lod_near_limit=450.0
dialog_stan_lod_far_limit=800.0

combat_animal_lod_near_limit=650.0
combat_animal_lod_far_limit=1400.0
normal_animal_lod_near_limit=650.0
normal_animal_lod_far_limit=1400.0
dialog_animal_lod_near_limit=650.0
dialog_animal_lod_far_limit=1400.0

combat_human_lod_near_limit=400.0
combat_human_lod_far_limit=700.0
normal_human_lod_near_limit=400.0
normal_human_lod_far_limit=700.0
dialog_human_lod_near_limit=400.0
dialog_human_lod_far_limit=700.0

dead_human_lod_near_limit=0.0
dead_human_far_limit=400.0
_INIEOF_
        sed -i -e 's/^Water_opacity_shift=.*/Water_opacity_shift=6/' \
               -e 's/^Water_opacity_pitch=.*/Water_opacity_pitch=20000.000000/' \
               -e 's/^Water_opacity_offset=.*/Water_opacity_offset=25000/' OUTCAST.ini
        ;;

    "$(eval_gettext 'High quality (Entropy settings)')")
        cat <<'_INIEOF_' > antialiasing_high.ini 
[Visual_Quality_Control]
Global_Antialiasing= 3
Combat_Antialiasing = 3
Normal_Antialiasing = 3
Dialog_Antialiasing = 3

lnd_aa_level=2

lnd_bilinear_range=16.0
_INIEOF_
        cat <<'_INIEOF_' > DOC_high.ini 
[Visual_Quality_Control]
lnd_base_layers=0

[Render_Mesh]
temples_world_view_angle=35.000000
temples_world_view_dist=12000.000000
temples_world_far_view_angle=38.000000
temples_world_far_view_dist=9000

marais_world_view_angle=35.000000
marais_world_view_dist=10000.000000
marais_world_far_view_angle=38.000000
marais_world_far_view_dist=8000

montagne_world_view_angle=35.000000
montagne_world_view_dist=11000.000000
montagne_world_far_view_angle=38.000000
montagne_world_far_view_dist=8000

ville_world_view_angle=35.000000
ville_world_view_dist=10000.000000
ville_world_far_view_angle=38.000000
ville_world_far_view_dist=7000

foret_world_view_angle=35.000000
foret_world_view_dist=9000.000000
foret_world_far_view_angle=38.000000
foret_world_far_view_dist=9000

neige_world_view_angle=35.000000
neige_world_view_dist=11000.000000
neige_world_far_view_angle=38.000000
neige_world_far_view_dist=8500

neige2_world_view_angle=35.000000
neige2_world_view_dist=11000.000000
neige2_world_far_view_angle=38.000000
neige2_world_far_view_dist=8500


[Render__mesh]
temples__mesh_back_plane=11000
marais__mesh_back_plane=9000
montagne__mesh_back_plane=10000
ville__mesh_back_plane=9000
foret__mesh_back_plane=8000
neige__mesh_back_plane=10000
neige2__mesh_back_plane=10000

[Render_big_mesh]
temples_big_mesh_back_plane=15500
marais_big_mesh_back_plane=14500
montagne_big_mesh_back_plane=14500
ville_big_mesh_back_plane=13000
foret_big_mesh_back_plane=15000
neige_big_mesh_back_plane=14500
neige2_big_mesh_back_plane=14500

[Fog]
temples_fog_density=7
temples_fog_sky_scale=1
marches_fog_density=7
marches_fog_sky_scale=2
montagne_fog_density=6
montagne_fog_sky_scale=2
ville_fog_density=8
ville_fog_sky_scale=2
foret_fog_density=7
foret_fog_sky_scale=2
neige_fog_density=7
neige_fog_sky_scale=3
burned_fog_density=7
burned_fog_sky_scale=3
_INIEOF_
        cat <<'_INIEOF_' > object_detail_high.ini 
[Visual_Quality_Control]
highobjectdetail=1
global_particle_level=2

[Leaves]
MinimumLeaveSize=2
MaximumLeaveSize=2.5
NumberOfLeavesSmall=12
NumberOfLeavesBig=18
MipmapLevel2=1300.000000
MipmapLevel1=2700.000000

[Snow]
Whirl_speed_ratio=200.000000
Whirl_speed=20000.000000
Transition_multiplier_snow_trigger=2.000000
Transition_base_snow_trigger=-1.000000
Side_move_effect=20.000000
Radius_around_cutter=1500.000000
Position_above_cutter=1000.000000
Minimum_weight=5.000000
Minimum_scale=10.000000
Maximum_weight=10.000000
Maximum_scale=12.000000
Good_weather_in_frames=2000
Fog_basic_altitude=1300.000000
Flakes_number=2000
Down_fog_speed=2.000000
Down_fog_altitude=-600.000000
Bad_weather_in_frames=4000
_INIEOF_
        cat <<'_INIEOF_' > 'Pentium III 550+ 64 Mb.ini'
[performance]
resolution=1280x800
cinemascope=false

crowdlevel=true
ambientsounds=true
bumpmapping=true
highanimationdetail=true

antialiasing=high
chardetail=high
objectdetail=high
prq=high
dof=high

doc=high
_INIEOF_
        cat <<'_INIEOF_' > character_detail_high.ini
[Visual_Quality_Control]
amh_shadow_limit_contraction_factor=1.5
amh_bump_disable_distance=2000

combat_stan_lod_near_limit=1000.0
combat_stan_lod_far_limit=2000.0
normal_stan_lod_near_limit=2000.0
normal_stan_lod_far_limit=2000.0
dialog_stan_lod_near_limit=1000.0
dialog_stan_lod_far_limit=2000.0

combat_animal_lod_near_limit=1000.0
combat_animal_lod_far_limit=2000.0
normal_animal_lod_near_limit=1000.0
normal_animal_lod_far_limit=2000.0
dialog_animal_lod_near_limit=1000.0
dialog_animal_lod_far_limit=2000.0

combat_human_lod_near_limit=1000.0
combat_human_lod_far_limit=2000.0
normal_human_lod_near_limit=1000.0
normal_human_lod_far_limit=2000.0
dialog_human_lod_near_limit=1000.0
dialog_human_lod_far_limit=1000.0

dead_human_lod_near_limit=0.0
dead_human_far_limit=400.0
_INIEOF_
        sed -i -e 's/^Water_opacity_shift=.*/Water_opacity_shift=6/' \
               -e 's/^Water_opacity_pitch=.*/Water_opacity_pitch=2000.000000/' \
               -e 's/^Water_opacity_offset=.*/Water_opacity_offset=5000/' OUTCAST.ini
        ;;
esac

# Allow for extensions
shopt -s nullglob
for conf in \$POL_USER_ROOT/configurations/configurators/"$SHORTCUT_NAME".*; do
    source "\$conf"
done

echo "CURRENT_LANG=\"\$CURRENT_LANG\"" > pol_configuration

POL_SetupWindow_Close
exit 0

_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKj4esACgkQ5TH6yaoTykeIoACcCOYuWR0uq8qoXFQvqdFFOiwE
j+EAn1mHMqTnQiEqIRl5v/+E0msGj/DN
=pi6c
-----END PGP SIGNATURE-----
