.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when exiting Pallet Town for the first time (two tiles)
@ Introduce Team Token and the Professor

@ People events
.equ PERSON_PROFESSOR, 0x3
.equ PERSON_TOKEN_GRUNT, 0x4

@ Tile that triggered script
.equ EVENT_TILE, 0x4001
.equ LEFT_TILE, 0x0
.equ RIGHT_TILE, 0x1

.global EventScript_PalletTokenIntro_Tile0
EventScript_PalletTokenIntro_Tile0:
  setvar EVENT_TILE LEFT_TILE
  goto EventScript_PalletTokenIntro_Start

.global EventScript_PalletTokenIntro_Tile1
EventScript_PalletTokenIntro_Tile1:
  setvar EVENT_TILE RIGHT_TILE
  goto EventScript_PalletTokenIntro_Start

EventScript_PalletTokenIntro_Start:
  lockall
  checkflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  call_if NOT_SET PalletTokenIntro_MeetToken
  setflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  release
  end

PalletTokenIntro_MeetToken:
  applymovement PERSON_TOKEN_GRUNT PalletTokenIntro_Move_Grunt_In
  waitmovement 0x0
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  call PalletTokenIntro_MeetProfessor
  return

PalletTokenIntro_Move_Grunt_In:
  .byte face_player
  .byte end_m

PalletTokenIntro_MeetProfessor:
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
  sound SOUND_HIGH_PITCH_BEEP
  showsprite PERSON_PROFESSOR
  compare EVENT_TILE LEFT_TILE
  call_if TRUE EventScript_PalletTokenIntro_Professor_Tile0
  compare EVENT_TILE RIGHT_TILE
  call_if TRUE EventScript_PalletTokenIntro_Professor_Tile1
  return

EventScript_PalletTokenIntro_Professor_Tile0:
  applymovement PERSON_PROFESSOR PalletTokenIntro_Move_Professor_Tile0
  waitmovement 0x0
  return

PalletTokenIntro_Move_Professor_Tile0:
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x13 @Step Right (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0x11 @Step Up (Normal)
  .byte 0xFE @End of Movements

EventScript_PalletTokenIntro_Professor_Tile1:
  applymovement PERSON_PROFESSOR PalletTokenIntro_Move_Professor_Tile1
  waitmovement 0x0
  return

PalletTokenIntro_Move_Professor_Tile1:
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
