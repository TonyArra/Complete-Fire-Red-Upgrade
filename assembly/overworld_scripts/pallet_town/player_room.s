.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"

.equ VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F, 0x4056

.global gMapScripts_PlayerRoom_Start
gMapScripts_PlayerRoom_Start:
    mapscript MAP_SCRIPT_ON_WARP_INTO_MAP_TABLE PlayerRoom_OnWarp
    .byte MAP_SCRIPT_TERMIN

PlayerRoom_OnWarp:
    @ compare 0x4056 0x1
    @ call_if 0x1 gMapScripts_NewGame_SpawnInBed
    levelscript 0x4056 0x0 PlayerRoom_EventScript_SpawnInBed
    .hword LEVEL_SCRIPT_TERMIN

PlayerRoom_EventScript_SpawnInBed:
    movesprite PLAYER 0x2 0x5
    spriteface PLAYER look_down
    setvar 0x4056 0x1
    end
