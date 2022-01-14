.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

.equ PERSON_TOKEN_GRUNT, 0x3

.global EventScript_PalletTokenIntro_Start
EventScript_PalletTokenIntro_Start:
  checkflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  call_if NOT_SET PalletTokenIntro_MeetToken
  release
  end

PalletTokenIntro_MeetToken:
  setflag FLAG_HIDE_ROUTE1_TOKEN_GRUNT
  applymovement PERSON_TOKEN_GRUNT PalletTokenIntro_Move_Grunt_In
  waitmovement 0x0
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  return

PalletTokenIntro_Move_Grunt_In:
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte end_m
