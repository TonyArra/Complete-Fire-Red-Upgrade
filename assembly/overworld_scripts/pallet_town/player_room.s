.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"

.equ MAP_SCENE_PLAYERS_HOUSE, 0x4056
.equ PERSON_RIVAL, 0x1
.equ SONG_GAME_CORNER_1, 0x146
.equ SONG_PALLET_TOWN, 0x12C

.global gMapScripts_PlayerRoom_Start
gMapScripts_PlayerRoom_Start:
  mapscript MAP_SCRIPT_ON_FRAME_TABLE PlayerRoom_OnFrameTable
  .byte MAP_SCRIPT_TERMIN

PlayerRoom_OnFrameTable:
  levelscript MAP_SCENE_PLAYERS_HOUSE NOT_SET PlayerRoom_EventScript_MeetRival
  .hword LEVEL_SCRIPT_TERMIN

PlayerRoom_EventScript_MeetRival:
  setvar MAP_SCENE_PLAYERS_HOUSE SET
  msgbox gText_PlayerRoom_Rival_WakeUp MSG_NORMAL
  playsong SONG_GAME_CORNER_1
  applymovement PERSON_RIVAL PlayerRoom_EventScript_RivalEnters
  waitmovement 0x0
  msgbox gText_PlayerRoom_Rival_Late MSG_NORMAL
  applymovement PERSON_RIVAL PlayerRoom_EventScript_RivalExits
  waitmovement 0x0
  fadesong SONG_PALLET_TOWN
  release
  end

PlayerRoom_EventScript_RivalEnters:
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_up
  .byte walk_left_onspot_fast
  .byte walk_left_onspot_fast
  .byte jump_onspot_left
  .byte jump_onspot_left
  .byte say_double_exclaim
  .byte end_m

PlayerRoom_EventScript_RivalExits:
  .byte run_down
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte set_invisible
  .byte end_m
