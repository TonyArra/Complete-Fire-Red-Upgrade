.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when entering professor lab for first time

.equ PERSON_PROFESSOR, 0x4
.equ PERSON_RIVAL, 0x8

.global gMapScripts_ProfessorsLab_Start
gMapScripts_ProfessorsLab_Start:
  mapscript MAP_SCRIPT_ON_FRAME_TABLE ProfessorsLab_OnFrameTable
  .byte MAP_SCRIPT_TERMIN

ProfessorsLab_OnFrameTable:
  levelscript VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x1 PlayScene
  .hword LEVEL_SCRIPT_TERMIN

PlayScene:
  lockall
  textcolor 0x0
  applymovement PERSON_PROFESSOR Move_Professor_EnterLab
  waitmovement 0x0
  hidesprite PERSON_PROFESSOR
  movesprite2 PERSON_PROFESSOR 0x6 0x3
  spritebehave PERSON_PROFESSOR 0x8
  clearflag FLAG_HIDE_OAK_IN_HIS_LAB
  applymovement PLAYER Move_Player_EnterLab
  applymovement PERSON_RIVAL Move_Rival_EnterLab
  waitmovement 0x0
  clearflag FLAG_DONT_TRANSITION_MUSIC
  playsong2 0x0
  fadedefault
  msgbox gText_ProfessorsLab_Rival_WhatGift MSG_KEEPOPEN
  closeonkeypress
  pause 0x3C
  msgbox gText_ProfessorsLab_Professor_Pokemon MSG_KEEPOPEN
  closeonkeypress
  pause 0x1E
  applymovement PERSON_RIVAL Move_Rival_WalkUp
  waitmovement 0x0
  msgbox gText_ProfessorsLab_Rival_NoFair MSG_KEEPOPEN
  msgbox gText_ProfessorsLab_Professor_BePatient MSG_KEEPOPEN
  setvar VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x2
  releaseall
  end

Move_Professor_EnterLab:
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte end_m

Move_Player_EnterLab:
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte end_m

Move_Rival_EnterLab:
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte walk_up
  .byte end_m

Move_Rival_WalkUp:
  .byte walk_up_onspot_fast
  .byte walk_up_onspot_fast
  .byte end_m
