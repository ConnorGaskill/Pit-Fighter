extends Node


enum Position {
	STANDING,
	ARM_BAR,
	FRONT_MOUNT,
	TIE
}

var a : Character

var b : Character

var current_position : Position

func set_position (a : Character, b : Character, position : Position):
	if Position.STANDING:
		a = null
		b = null
	if Position.ARM_BAR or Position.FRONT_MOUNT:
		a = a
		b = b
	current_position = position
