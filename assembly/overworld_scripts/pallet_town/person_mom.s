.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ Person script for Mom in player house

.equ PERSON_MOM, 0x1
.equ SCRIPT_MOM_REST, 0x8168C4A

.global EventScript_Person_Mom_Start
EventScript_Person_Mom_Start:
  lock
  faceplayer
  checkflag FLAG_BEAT_RIVAL_IN_OAKS_LAB
  goto_if SET SCRIPT_MOM_REST
  msgbox gText_PersonMom_BeCareful MSG_NORMAL
  applymovement PERSON_MOM Move_Mom_FaceDefault
  waitmovement 0x0
  release
  end

Move_Mom_FaceDefault:
  .byte face_default
  .byte end_m
