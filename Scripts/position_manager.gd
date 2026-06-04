extends Node

class_name Position_Manager

enum Position {
	STANDING,
	ARM_BAR,
	FRONT_MOUNT,
	TIE
}

var a : Character

var b : Character

static var _current_position : Position

static var current_position : Position : 
	get: 
		return _current_position

func _ready() -> void:
	GameManager.set_position.connect(set_position)

func set_position (a : Character, b : Character, position : Position):
	if position == Position.STANDING or position == Position.TIE:
		self.a = null
		self.b = null
	if position == Position.ARM_BAR or position == Position.FRONT_MOUNT:
		self.a = a
		self.b = b
	_current_position = position
