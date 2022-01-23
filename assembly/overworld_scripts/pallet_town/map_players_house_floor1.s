.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Person script for talking to Mom in player house

.equ PERSON_MOM, 0x1
.equ PERSON_RIVAL, 0x2

.global gMapScripts_PlayersHouseFloor1_Start
gMapScripts_PlayersHouseFloor1_Start:
  mapscript MAP_SCRIPT_ON_FRAME_TABLE PlayersHouseFloor1_OnFrameTable
  .byte MAP_SCRIPT_TERMIN

PlayersHouseFloor1_OnFrameTable:
  levelscript VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x1 PlayerHouseFloor1_Start
  .hword LEVEL_SCRIPT_TERMIN

PlayerHouseFloor1_Start:
  lock
  setvar VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x2
  call RunPastMom
  call TalkToMom
  call Rival_RunOutDoor
  release
  end

RunPastMom:
  applymovement PERSON_RIVAL Move_Rival_RunPastMom
  applymovement PLAYER Move_Player_RunPastMom
  waitmovement 0x0
  sound SOUND_HIGH_PITCH_BEEP
  applymovement PERSON_MOM Move_Mom_Exclaim
  waitmovement 0x0
  applymovement PERSON_MOM Move_Mom_FaceDown
  applymovement PERSON_RIVAL Move_FaceUp
  applymovement PLAYER Move_FaceUp
  waitmovement 0x0
  return

Move_Rival_RunPastMom:
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte end_m

Move_Player_RunPastMom:
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_down
  .byte run_left
  .byte run_left
  .byte run_left
  .byte end_m

Move_Mom_FaceDown:
  .byte walk_down_onspot_fastest
  .byte end_m

Move_Mom_Exclaim:
  .byte exclaim
  .byte end_m

Move_FaceUp:
  .byte walk_up_onspot_fastest
  .byte end_m

TalkToMom:
  msgbox gText_PlayerHouseFloor1_Mom_Wow MSG_NORMAL
  call Rival_Jump
  msgbox gText_PlayerHouseFloor1_Rival_PlayerOverslept MSG_NORMAL
  return

Rival_Jump:
  sound SOUND_JUMP
  applymovement PERSON_RIVAL Move_Rival_Jump
  waitmovement 0x0
  return

Move_Rival_Jump:
  .byte jump_onspot_up
  .byte end_m

Rival_RunOutDoor:
  applymovement PERSON_RIVAL Move_Rival_RunOutDoor
  waitmovement 0x0
  sound SOUND_DOOR_OPEN
  hidesprite PERSON_RIVAL
  return

Move_Rival_RunOutDoor:
  .byte run_left
  .byte run_left
  .byte run_down
  .byte end_m
