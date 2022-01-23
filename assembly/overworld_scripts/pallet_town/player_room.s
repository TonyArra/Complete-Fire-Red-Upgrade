.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Map script that runs when starting a new game in the player room.
@ Overrides all existing level scripts for this room

@ CFRU Expanded Overworld Sprites
.equ MALE_SLEEPING_SPRITE, 0x0200
.equ FEMALE_SLEEPING_SPRITE, 0x0201

@ Person Events
.equ PERSON_RIVAL, 0x1
.equ PERSON_SLEEPING_PLAYER, 0x2

.global gMapScripts_PlayerRoom_Start
gMapScripts_PlayerRoom_Start:
  mapscript MAP_SCRIPT_ON_LOAD PlayerRoom_OnLoad
  mapscript MAP_SCRIPT_ON_FRAME_TABLE PlayerRoom_OnFrameTable
  .byte MAP_SCRIPT_TERMIN

PlayerRoom_OnLoad:
  compare VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x0
  call_if equal RenderSleepingSprite
  end

RenderSleepingSprite:
  checkgender
  compare LASTRESULT BOY
  call_if equal RenderMaleSleepingSprite
  compare LASTRESULT GIRL
  call_if equal RenderFemaleSleepingSprite
  return

RenderMaleSleepingSprite:
  setvar VAR_RUNTIME_CHANGEABLE MALE_SLEEPING_SPRITE
  return

RenderFemaleSleepingSprite:
  setvar VAR_RUNTIME_CHANGEABLE FEMALE_SLEEPING_SPRITE
  return

PlayerRoom_OnFrameTable:
  levelscript VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x0 PlayerRoom_EventScript_MeetRival
  .hword LEVEL_SCRIPT_TERMIN

PlayerRoom_EventScript_MeetRival:
  setvar VAR_MAP_SCENE_PALLET_TOWN_PLAYERS_HOUSE_2F 0x1
  call SetHealingPlaceToHome
  call Player_Sleep
  msgbox gText_PlayerRoom_Rival_WakeUp MSG_NORMAL
  call Player_WakeUp
  playsong SONG_GAME_CORNER_1
  call Rival_Enters
  msgbox gText_PlayerRoom_Rival_Late MSG_NORMAL
  call Rival_Exits
  fadesong SONG_PALLET_TOWN
  hidesprite PERSON_RIVAL
  release
  end

Player_Sleep:
  applymovement PLAYER Move_Player_Hide
  msgbox gText_PlayerRoom_Player_Snore MSG_NORMAL
  pause 0x3C
  msgbox gText_PlayerRoom_Player_Snore MSG_NORMAL
  pause 0x3C
  return

Move_Player_Hide:
  .byte set_invisible
  .byte end_m

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

Player_WakeUp:
  sound SOUND_HIGH_PITCH_BEEP
  applymovement PLAYER Move_Player_WakeUp
  waitmovement 0x0
  hidesprite PERSON_SLEEPING_PLAYER
  return

Move_Player_WakeUp:
  .byte set_visible
  .byte exclaim
  .byte end_m

Rival_Exits:
  applymovement PERSON_RIVAL Move_Rival_Exits
  waitmovement 0x0
  return

Move_Rival_Exits:
  .byte run_up
  .byte run_up
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_down
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte run_right
  .byte end_m

SetHealingPlaceToHome:
  sethealingplace 0x1
  return
