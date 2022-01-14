.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

.equ PERSON_RIVAL, 0x1

.global gMapScripts_PlayerRoom_Start
gMapScripts_PlayerRoom_Start:
  mapscript MAP_SCRIPT_ON_FRAME_TABLE PlayerRoom_OnFrameTable
  .byte MAP_SCRIPT_TERMIN

PlayerRoom_OnFrameTable:
  levelscript VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x0 PlayerRoom_EventScript_MeetRival
  .hword LEVEL_SCRIPT_TERMIN

PlayerRoom_EventScript_MeetRival:
  setvar VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x1
  msgbox gText_PlayerRoom_Rival_WakeUp MSG_NORMAL
  playsong SONG_GAME_CORNER_1
  call Rival_Enters
  msgbox gText_PlayerRoom_Rival_Late MSG_NORMAL
  call Rival_Exits
  fadesong SONG_PALLET_TOWN
  msgbox gText_PlayerRoom_Player_Festival1 MSG_NORMAL
  msgbox gText_PlayerRoom_Player_Festival2 MSG_NORMAL
  setflag FLAG_HIDE_RIVAL_IN_PLAYER_ROOM
  release
  end

Rival_Enters:
  applymovement PERSON_RIVAL Move_Rival_Enters
  waitmovement 0x0
  sound SOUND_JUMP
  applymovement PERSON_RIVAL Move_Rival_Jump
  waitmovement 0x0
  sound SOUND_JUMP
  applymovement PERSON_RIVAL Move_Rival_Jump
  waitmovement 0x0
  applymovement PERSON_RIVAL Move_Rival_Exclaim
  waitmovement 0x0
  return

Move_Rival_Enters:
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
  .byte end_m

Move_Rival_Jump:
  .byte jump_onspot_left
  .byte end_m

Move_Rival_Exclaim:
  .byte say_double_exclaim
  .byte end_m

Rival_Exits:
  applymovement PERSON_RIVAL Move_Rival_Exits
  waitmovement 0x0
  return

Move_Rival_Exits:
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
  .byte end_m
