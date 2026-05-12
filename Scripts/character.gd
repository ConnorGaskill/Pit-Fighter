extends Node2D

class_name Character

signal hp_changed(current_hp:int, max_hp:int)

@export var is_player : bool

@export var max_hp : int

@export var current_hp : int

@export var max_stamina : int

@export var current_stamina : int

@export var max_instinct : int

@export var current_instinct : int 

@export var known_actions : Array[Action]

@export var known_reactions : Array[Reaction]

#var known_reactions : Dictionary

func end_turn():
	pass
	
func lose_stamina (amount : int):
	pass
	
func lose_instinct (amount : int):
	pass
	
	
func roll_initiative():
	return randf_range(0, 20)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_player:
		GameManager.player_character = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_hp(amount:int):

	current_hp += amount
	current_hp = clamp(current_hp, 0, max_hp)

	hp_changed.emit(current_hp, max_hp)
