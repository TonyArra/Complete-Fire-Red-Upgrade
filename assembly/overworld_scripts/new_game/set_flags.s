.align 2

.include "../garticmon_defines.s"
.include "../xse_commands.s"
.include "../xse_defines.s"

@; Script to set initial values of flags and vars for a new game.
@; TODO: Replace remaining flags with defines

.global SystemScript_NewGameSetFlags
SystemScript_NewGameSetFlags:
  setflag FLAG_HIDE_OAK_IN_HIS_LAB
  setflag FLAG_HIDE_OAK_IN_PALLET_TOWN
  setflag FLAG_HIDE_RIVAL_IN_LAB
  setflag FLAG_HIDE_BILL_HUMAN_SEA_COTTAGE
  setflag 0x0092
  setflag 0x0035
  setflag 0x0036
  setflag 0x0037
  setflag 0x003C
  setflag 0x003D
  setflag 0x00A1
  setflag 0x003F
  setflag 0x004F
  setflag 0x005A
  setflag 0x00A3
  setflag 0x00A4
  setflag 0x0062
  setflag 0x006B
  setflag 0x00A2
  setflag 0x008C
  setflag 0x006C
  setflag 0x006D
  setflag 0x006E
  setflag 0x006F
  setflag 0x0075
  setflag 0x0074
  setflag 0x007B
  setflag 0x007C
  setflag 0x007D
  setflag 0x0076
  setflag 0x0091
  setflag 0x0097
  setflag 0x0090
  setflag 0x0094
  setflag 0x0095
  setflag 0x0096
  setflag 0x0099
  setflag 0x00A5
  setflag 0x00A6
  setflag 0x00A7
  setflag 0x00A8
  setflag 0x00A9
  setflag 0x00AA
  setflag 0x00AB
  setflag 0x00AC
  setflag 0x009D
  setflag 0x009E
  setflag 0x009F
  setflag 0x00A0
  setflag 0x00AE
  setvar VAR_MASSAGE_COOLDOWN_STEP_COUNTER 0x01F4
  end
