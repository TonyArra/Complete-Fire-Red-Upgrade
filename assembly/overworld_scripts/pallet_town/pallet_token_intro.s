.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"

.global EventScript_PalletTokenIntro_Start
EventScript_PalletTokenIntro_Start:
  msgbox gText_PalletTokenIntro_Grunt_HeyKids MSG_NORMAL
  release
  end
