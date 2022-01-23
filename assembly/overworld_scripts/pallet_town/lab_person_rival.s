.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@ NPC - Pallet Town - Rival

.global EventScript_PalletTown_Lab_Person_Rival_Start
EventScript_PalletTown_Lab_Person_Rival_Start:
  lock
  faceplayer
  compare VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x3
  call_if equal Message_Person_Rival_MyPokemon
  compare VAR_MAP_SCENE_PALLET_TOWN_PROFESSOR_OAKS_LAB 0x2
  call_if equal Message_Person_Rival_YouGoFirst
  release
  end

Message_Person_Rival_MyPokemon:
  msgbox gText_PalletTown_Lab_Person_Rival_MyPokemon MSG_NORMAL
  return

Message_Person_Rival_YouGoFirst:
  msgbox gText_PalletTown_Lab_Person_Rival_YouGoFirst MSG_NORMAL
  return
