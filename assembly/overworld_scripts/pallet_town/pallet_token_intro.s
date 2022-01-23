.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when exiting Pallet Town for the first time
@ Introduce Team Token and the Professor

@ Person events
.equ PERSON_PROFESSOR, 0x3
.equ PERSON_TOKEN_GRUNT, 0x4
.equ PERSON_RIVAL, 0x5

.global EventScript_PalletTokenIntro_Start
EventScript_PalletTokenIntro_Start:
  checkflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  call_if NOT_SET PalletTokenIntro_Start
  end

PalletTokenIntro_Start:
  lockall
  call MeetTokenGrunt
  call MeetProfessor
  releaseall
  end

MeetTokenGrunt:
  sound SOUND_INSERT_COIN
  applymovement PERSON_RIVAL Move_Rival_FaceUp
  waitmovement 0x0
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  msgbox gText_PalletTokenIntro_Rival_NFT MSG_NORMAL
  return

Move_Rival_FaceUp:
  .byte walk_up_onspot_fastest
  .byte end_m

MeetProfessor:
  setvar 0x8004 0x0
  setvar 0x8005 0x2
  special 0x174
  textcolor BLUE
  pause 0x1E
  playsong SONG_OAKS_THEME 0x0
  preparemsg gText_PalletTokenIntro_Professor_Wait
  waitmsg
  pause 0x55
  closeonkeypress
  applymovement PLAYER Move_FaceDown
  applymovement PERSON_RIVAL Move_FaceDown
  waitmovement 0x0
  sound SOUND_HIGH_PITCH_BEEP
  applymovement PLAYER Move_Exclamation
  applymovement PERSON_RIVAL Move_Exclamation
  waitmovement 0x0
  pause 0x1E
  showsprite PERSON_PROFESSOR
  call Professor_Enters
  pause 0x1E
  msgbox gText_PalletTokenIntro_Professor_Shoo MSG_NORMAL
  call Grunt_RunAway
  msgbox gText_PalletTokenIntro_Professor_ComeWithMe MSG_KEEPOPEN
  closeonkeypress
  pause 0x1E
  call FollowProfessor
  @ Enter Lab
  setdooropen 0x10 0xD
  applymovement PERSON_PROFESSOR Move_Professor_EnterLab
  applymovement PLAYER Move_Player_EnterLab
  applymovement PERSON_RIVAL Move_Rival_EnterLab
  waitmovement 0x0
  setdoorclosed 0x10 0xD
  setvar VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x1
  clearflag FLAG_HIDE_OAK_IN_HIS_LAB
  clearflag FLAG_HIDE_RIVAL_IN_LAB
  setvar VAR_MAP_SCENE_PALLET_TOWN_OAK 0x1
  hidesprite PERSON_PROFESSOR
  setflag FLAG_DONT_TRANSITION_MUSIC
  hidesprite PERSON_RIVAL
  warp 0x4 0x3 0xFF 0x6 0xC
  waitstate
  return

Move_FaceDown:
  .byte walk_down_onspot_fastest
  .byte end_m

Move_Exclamation:
  .byte exclaim
  .byte end_m

Professor_Enters:
  applymovement PERSON_PROFESSOR Move_Professor_Enters
  waitmovement 0x0
  return

Move_Professor_Enters:
  .byte walk_up
  .byte walk_up
  .byte walk_right
  .byte walk_up
  .byte walk_up
  .byte walk_right
  .byte walk_up
  .byte walk_up
  .byte end_m

Grunt_RunAway:
  sound SOUND_FLEE
  applymovement PERSON_TOKEN_GRUNT Move_Grunt_RunAway
  waitmovement 0x0
  hidesprite PERSON_TOKEN_GRUNT
  return

Move_Grunt_RunAway:
  .byte run_up
  .byte run_up
  .byte run_up
  .byte run_up
  .byte run_up
  .byte end_m

FollowProfessor:
  applymovement PERSON_PROFESSOR Move_Professor_FollowProfessor
  applymovement PLAYER Move_Player_FollowProfessor
  applymovement PERSON_RIVAL Move_Rival_FollowProfessor
  waitmovement 0x0
  return

Move_Professor_FollowProfessor:
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_right
  .byte walk_right
  .byte walk_right
  .byte walk_right
  .byte walk_up_onspot_fastest
  .byte end_m

Move_Player_FollowProfessor:
  .byte walk_down
  .byte walk_down
  .byte walk_left
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_right
  .byte walk_right
  .byte walk_right
  .byte end_m

Move_Rival_FollowProfessor:
  .byte walk_right
  .byte walk_down
  .byte walk_down
  .byte walk_left
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_right
  .byte walk_right
  .byte walk_right
  .byte end_m

Move_Professor_EnterLab:
  .byte walk_up
  .byte set_invisible
  .byte end_m

Move_Player_EnterLab:
  .byte walk_right
  .byte walk_up
  .byte set_invisible
  .byte end_m

Move_Rival_EnterLab:
  .byte walk_right
  .byte walk_up
  .byte set_invisible
  .byte end_m
