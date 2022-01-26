.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

.equ PERSON_PROFESSOR, 0x4
.equ PERSON_RIVAL, 0x8

.global EventScript_PalletTown_Lab_ProfessorBattle_Start
EventScript_PalletTown_Lab_ProfessorBattle_Start:
  lock
  call TalkToProfessor
  call StartBattle
  release
  end

TalkToProfessor:
  applymovement PERSON_RIVAL Move_Rival_ToPlayer
  waitmovement 0x0
  msgbox gText_PalletTown_Lab_ProfessorBattle_Prof_HoldIt MSG_NORMAL
  sound SOUND_HIGH_PITCH_BEEP
  applymovement PLAYER Move_FaceUpExclaim
  applymovement PERSON_RIVAL Move_FaceUpExclaim
  applymovement PERSON_PROFESSOR Move_Prof_ToPlayer
  waitmovement 0x0
  msgbox gText_PalletTown_Lab_ProfessorBattle_Prof_FightMe MSG_NORMAL
  applymovement PLAYER Move_Player_LookAtRival
  applymovement PERSON_RIVAL Move_Rival_LookAtPlayer
  waitmovement 0x0
  msgbox gText_PalletTown_Lab_ProfessorBattle_Slime_WeCanTakeYou MSG_NORMAL
  msgbox gText_PalletTown_Lab_ProfessorBattle_Prof_WannaBet MSG_NORMAL
  return

StartBattle:
  trainerbattle12 0xC TRAINER_PROFESSOR_IN_LAB TRAINER_SLIMEMANTHA_IN_LAB_1 BACKSPRITE_SLIMEMANTHA 0x0 gText_PalletTown_Lab_ProfessorBattle_Loss
  return

Move_Rival_ToPlayer:
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_left
  .byte run_down
  .byte run_down
  .byte run_down
  .byte end_m

Move_Prof_ToPlayer:
  .byte walk_right
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte walk_down
  .byte end_m

Move_FaceUpExclaim:
  .byte exclaim
  .byte walk_up_onspot_fastest
  .byte end_m

Move_Player_LookAtRival:
  .byte walk_left_onspot
  .byte pause_long
  .byte walk_up_onspot
  .byte end_m

Move_Rival_LookAtPlayer:
  .byte walk_right_onspot
  .byte pause_long
  .byte walk_up_onspot
  .byte end_m
