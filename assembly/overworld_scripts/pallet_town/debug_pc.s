.thumb
.align 2

.include "../asm_defines.s"
.include "../xse_commands.s"
.include "../xse_defines.s"

@;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ First species number to give at PC
.equ FIRST_SPECIES, 0x1

@ Last species number to give at PC
.equ LAST_SPECIES, 0x22

@ Add script to PC in players room
@ Gives all normal and shiny custom Pokemon
@ Enables Pokedex and Pokemon menus
.global EventScript_DebugPc_Start
EventScript_DebugPc_Start:
  @ Required for PC to work START
	special 0x187
	compare 0x800D 0x2
	if 0x1 _goto 0x81A7AE0
	lockall
	checkflag 0x841
	if 0x1 _goto 0x81A698E
	setvar 0x8004 0x1B
	special 0x17D
	setvar 0x8004 0x0
	special 0xD6
	sound 0x4
	msgbox 0x81A5075 MSG_KEEPOPEN
	checkflag 0x1002
	if 0x1 _goto 0x81A6998
	@ Required for PC to work END
	msgbox gText_DebugPc_Loading MSG_KEEPOPEN
	setvar 0x4001 FIRST_SPECIES @ reset loop counter
	call EventScript_DebugPc_GiveAllNormal
	setvar 0x4001 FIRST_SPECIES @ reset loop counter
	call EventScript_DebugPc_GiveAllShiny
	call EventScript_DebugPc_AccessPC
  end

EventScript_DebugPc_GiveAllNormal:
	givepokemon 0x4001 0x5 ITEM_RARE_CANDY 0x0 0x0 0x0
	addvar 0x4001 0x1
	compare 0x4001 LAST_SPECIES
	goto_if lessorequal EventScript_DebugPc_GiveAllNormal
	return

EventScript_DebugPc_GiveAllShiny:
	setvar 0x8000 0x1 @ Move 1
	setvar 0x8001 0x1 @ Move 2
	setvar 0x8002 0x1 @ Move 3
	setvar 0x8003 0x1 @ Move 4
	setvar 0x8004 0x1 @ Nature
	setvar 0x8005 0x1 @ 0 if not shiny. 1 if shiny.
	setvar 0x8006 0x1 @ HP IV
	setvar 0x8007 0x1 @ Attack IV
	setvar 0x8008 0x1 @ Defense IV
	setvar 0x8009 0x1 @ Speed IV
	setvar 0x800A 0x1 @ Special Attack IV
	setvar 0x800B 0x1 @ Special Defense IV
	givepokemon 0x4001 0x5 0x44 0x0 0x1 0x0
	addvar 0x4001 0x1
	compare 0x4001 LAST_SPECIES
	goto_if lessorequal EventScript_DebugPc_GiveAllShiny
	return

EventScript_DebugPc_AccessPC:
	setflag 0x1002
	setflag 0x828 @ activate pokemon menu
	setflag 0x829 @ activate pokedex menu
	preparemsg 0x81A508A @"Which PC should be accessed?"
	waitmsg
	special 0x106
	waitstate
	goto 0x81A69A8
	return
