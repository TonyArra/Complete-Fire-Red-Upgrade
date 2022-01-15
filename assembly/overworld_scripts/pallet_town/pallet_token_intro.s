.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when exiting Pallet Town for the first time
@ Introduce Team Token and the Professor

@ Person events
.equ PERSON_PROFESSOR, 0x3
.equ PERSON_TOKEN_GRUNT, 0x4

.global EventScript_PalletTokenIntro_Start
EventScript_PalletTokenIntro_Start:
  lockall
  checkflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  call_if NOT_SET MeetTokenGrunt
  setflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  releaseall
  end

MeetTokenGrunt:
  sound SOUND_INSERT_COIN
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  call MeetProfessor
  return

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
  applymovement PLAYER Move_Player_FaceDown
  waitmovement 0x0
  sound SOUND_HIGH_PITCH_BEEP
  applymovement PLAYER Move_Player_Exclamation
  waitmovement 0x0
  pause 0x1E
  showsprite PERSON_PROFESSOR
  call Professor_Enters
  pause 0x1E
  msgbox gText_PalletTokenIntro_Professor_Shoo MSG_NORMAL
  call Grunt_RunAway
  msgbox gText_PalletTokenIntro_Professor_BeCareful MSG_NORMAL
  msgbox gText_PalletTokenIntro_Professor_ComeWithMe MSG_KEEPOPEN
  closeonkeypress
  pause 0x1E
  call FollowProfessor
  @ Enter Lab
  setdooropen 0x10 0xD
  applymovement PERSON_PROFESSOR Move_Professor_EnterLab
  applymovement PLAYER Move_Player_EnterLab
  waitmovement 0x0
  setdoorclosed 0x10 0xD
  setvar VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x1
  clearflag FLAG_HIDE_OAK_IN_HIS_LAB
  setvar VAR_MAP_SCENE_PALLET_TOWN_OAK 0x1
  setflag FLAG_HIDE_OAK_IN_PALLET_TOWN
  setflag FLAG_DONT_TRANSITION_MUSIC
  warp 0x4 0x3 0xFF 0x6 0xC
  waitstate
  return

Move_Player_FaceDown:
  .byte walk_down_onspot_fastest
  .byte end_m

Move_Player_Exclamation:
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
  applymovement PERSON_TOKEN_GRUNT Move_Grunt_RunAway
  sound SOUND_FLEE
  return

Move_Grunt_RunAway:
  .byte run_up
  .byte run_up
  .byte run_up
  .byte run_up
  .byte end_m

FollowProfessor:
  applymovement PERSON_PROFESSOR Move_Professor_FollowProfessor
  applymovement PLAYER Move_Player_FollowProfessor
  waitmovement 0x0
  return

Move_Professor_FollowProfessor:
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
