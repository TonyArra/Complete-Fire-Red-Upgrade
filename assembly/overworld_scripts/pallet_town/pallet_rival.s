.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Script triggered when talking to Rival in Pallet Town when facing Token Grunt

.equ PERSON_RIVAL, 0x5

.global EventScript_PalletRival_Start
EventScript_PalletRival_Start:
  lock
  msgbox gText_PalletRival_Rival_MonkeyEars MSG_NORMAL
  applymovement PERSON_RIVAL Move_Rival_Smile
  release
  end

Move_Rival_Smile:
  .byte say_smile
  .byte end_m
