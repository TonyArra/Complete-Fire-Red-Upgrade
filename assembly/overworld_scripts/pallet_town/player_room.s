.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"

.equ MAP_SCENE_PLAYERS_HOUSE, 0x4056

.global gMapScripts_PlayerRoom_Start
gMapScripts_PlayerRoom_Start:
    mapscript MAP_SCRIPT_ON_FRAME_TABLE PlayerRoom_OnFrameTable
    .byte MAP_SCRIPT_TERMIN

PlayerRoom_OnFrameTable:
    levelscript MAP_SCENE_PLAYERS_HOUSE NOT_SET PlayerRoom_EventScript_Intro
    .hword LEVEL_SCRIPT_TERMIN

PlayerRoom_EventScript_Intro:
    setvar MAP_SCENE_PLAYERS_HOUSE SET
    msgbox gText_PlayerRoom_WakeUp MSG_NORMAL
    release
    end
