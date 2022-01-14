.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when exiting Pallet Town for the first time (two tiles)
@ Introduce Team Token and the Professor

@ Person events
.equ PERSON_PROFESSOR, 0x3
.equ PERSON_TOKEN_GRUNT, 0x4

@ Tile that triggered script
.equ EVENT_TILE, 0x4001
.equ LEFT_TILE, 0x0
.equ RIGHT_TILE, 0x1

.global EventScript_PalletTokenIntro_Tile0
EventScript_PalletTokenIntro_Tile0:
  setvar EVENT_TILE LEFT_TILE
  goto PalletTokenIntro_Start

.global EventScript_PalletTokenIntro_Tile1
EventScript_PalletTokenIntro_Tile1:
  setvar EVENT_TILE RIGHT_TILE
  goto PalletTokenIntro_Start

PalletTokenIntro_Start:
  lockall
  checkflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  call_if NOT_SET MeetTokenGrunt
  setflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  releaseall
  end

MeetTokenGrunt:
  applymovement PERSON_TOKEN_GRUNT Move_Grunt_FacePlayer
  waitmovement 0x0
  sound SOUND_INSERT_COIN
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  call MeetProfessor
  return

Move_Grunt_FacePlayer:
  .byte face_player
  .byte end_m

@ This script was mostly taken from the game with hex replaced by vars.
@ Kept the logic for splitting the behavior based on which of the two tiles
@ the player is standing on.
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
  compare EVENT_TILE LEFT_TILE
  call_if equal Professor_Enters_Tile0
  compare EVENT_TILE RIGHT_TILE
  call_if equal Professor_Enters_Tile1
  pause 0x1E
  msgbox gText_PalletTokenIntro_Professor_Shoo MSG_NORMAL
  call Grunt_RunAway
  msgbox gText_PalletTokenIntro_Professor_BeCareful MSG_NORMAL
  msgbox gText_PalletTokenIntro_Professor_ComeWithMe MSG_KEEPOPEN
  closeonkeypress
  pause 0x1E
  compare EVENT_TILE LEFT_TILE
  call_if equal FollowProfessor_Tile0
  compare EVENT_TILE RIGHT_TILE
  call_if equal FollowProfessor_Tile1
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
  .byte 0x2D @Face Down (Delayed)
  .byte 0xFE @End of Movements

Move_Player_Exclamation:
  .byte 0x62 @Exclamation Mark (!)
  .byte 0xFE @End of Movements

Professor_Enters_Tile0:
  applymovement PERSON_PROFESSOR Move_Professor_Enters_Tile0
  waitmovement 0x0
  return

Move_Professor_Enters_Tile0:
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0xFE @End of Movements

Professor_Enters_Tile1:
  applymovement PERSON_PROFESSOR Move_Professor_Enters_Tile1
  waitmovement 0x0
  return

Move_Professor_Enters_Tile1:
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0xFE @End of Movements

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

FollowProfessor_Tile0:
  applymovement PERSON_PROFESSOR Move_Professor_FollowProfessor_Tile0
  applymovement PLAYER Move_Player_FollowProfessor_Tile0
  waitmovement 0x0
  return

Move_Professor_FollowProfessor_Tile0:
  .byte 0x10 @Step Down (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x2E @Face Up (Delayed)
  .byte 0xFE @End of Movements

Move_Player_FollowProfessor_Tile0:
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0xFE @End of Movements

FollowProfessor_Tile1:
  applymovement PERSON_PROFESSOR Move_Professor_FollowProfessor_Tile1
  applymovement PLAYER Move_Player_FollowProfessor_Tile1
  waitmovement 0x0
  return

Move_Professor_FollowProfessor_Tile1:
  .byte 0x10 @Step Down (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x2E @Face Up (Delayed)
  .byte 0xFE @End of Movements

Move_Player_FollowProfessor_Tile1:
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x12 @Step Left (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x10 @Step Down (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0xFE @End of Movements

Move_Professor_EnterLab:
  .byte 0x11 @Step Up (Normal)
  .byte 0x60 @Hide
  .byte 0xFE @End of Movements

Move_Player_EnterLab:
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x60 @Hide
  .byte 0xFE @End of Movements
