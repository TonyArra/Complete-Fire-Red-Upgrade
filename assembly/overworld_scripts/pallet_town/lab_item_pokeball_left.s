.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../garticmon_defines.s"

@; Event script for Pokeballs in Professor's Lab
@; Three global events based on WHICH_POKEBALL was interacted with.

@; Temp Vars
.equ WHICH_POKEBALL, 0x4001
.equ POKEMON_IN_BALL, 0x4002

@; Pokeballs
.equ LEFT_BALL, 0x0
.equ MIDDLE_BALL, 0x1
.equ RIGHT_BALL, 0x2

@; Pokemon
.equ ZAPINDOS, 0x1E
.equ TADORB, 0x0B
.equ BINGLY, 0x04

.global EventScript_PalletTown_Lab_Item_PokeballLeft_Start
EventScript_PalletTown_Lab_Item_PokeballLeft_Start:
  lock
  faceplayer
  setvar 0x4001 0x0
  setvar POKEMON_IN_BALL ZAPINDOS
  setvar 0x4003 BINGLY
  setvar 0x4004 0x7
  compare 0x4055 0x3
  goto_if 0x4 0x8169DE4
  compare 0x4055 0x2
  goto_if 0x1 ViewPokemon
  msgbox 0x818EA19 MSG_KEEPOPEN
  release
  end
  end

.global EventScript_PalletTown_Lab_Item_PokeballMiddle_Start
EventScript_PalletTown_Lab_Item_PokeballMiddle_Start:
  lock
  faceplayer
  setvar 0x4001 0x1
  setvar POKEMON_IN_BALL TADORB
  setvar 0x4003 ZAPINDOS
  setvar 0x4004 0x5
  compare 0x4055 0x3
  goto_if 0x4 0x8169DE4
  compare 0x4055 0x2
  goto_if 0x1 ViewPokemon
  msgbox 0x818EA19 MSG_KEEPOPEN
  release
  end

.global EventScript_PalletTown_Lab_Item_PokeballRight_Start
EventScript_PalletTown_Lab_Item_PokeballRight_Start:
  lock
  faceplayer
  setvar 0x4001 0x2
  setvar POKEMON_IN_BALL BINGLY
  setvar 0x4003 TADORB
  setvar 0x4004 0x6
  compare 0x4055 0x3
  goto_if 0x4 0x8169DE4
  compare 0x4055 0x2
  goto_if 0x1 ViewPokemon
  msgbox 0x818EA19 MSG_KEEPOPEN
  release
  end

Message_LastPokemon:
  msgbox 0x818EA45 MSG_KEEPOPEN
  release
  end

ViewPokemon:
  applymovement 0x4 0x81A75EF
  waitmovement 0x0
  showpokepic 0x4002 0xA 0x3
  textcolor 0x0
  compare 0x4001 0x0
  goto_if 0x1 Message_Professor_PokeballLeft
  compare 0x4001 0x1
  goto_if 0x1 Message_Professor_PokeballMiddle
  compare 0x4001 0x2
  goto_if 0x1 Message_Professor_PokeballRight
  end

Message_Professor_PokeballLeft:
  msgbox gText_PalletTown_Lab_PokeballLeft MSG_YESNO
  compare LASTRESULT 0x1
  goto_if 0x1 0x8169C74
  compare LASTRESULT 0x0
  goto_if 0x1 0x8169C71
  end

Message_Professor_PokeballMiddle:
  msgbox gText_PalletTown_Lab_PokeballMiddle MSG_YESNO
  compare LASTRESULT 0x1
  goto_if 0x1 0x8169C74
  compare LASTRESULT 0x0
  goto_if 0x1 0x8169C71
  end

Message_Professor_PokeballRight:
  msgbox gText_PalletTown_Lab_PokeballRight MSG_YESNO
  compare LASTRESULT 0x1
  goto_if 0x1 0x8169C74
  compare LASTRESULT 0x0
  goto_if 0x1 0x8169C71
  end
