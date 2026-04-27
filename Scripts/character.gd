extends Node2D

class_name Character

signal OnTakeDamage (hp : int)

@export var max_hp : int

@export var current_hp : int

@export var max_stamina : int

@export var current_stamina : int

@export var max_instinct : int

@export var current_instinct : int 

@export var actions : Array[Action]

#var known_reactions : Dictionary
func begin_turn():
	pass

func end_turn():
	pass
	
func lose_hp (amount : int):
	pass
	
func lose_stamina (amount : int):
	pass
	
func lose_instinct (amount : int):
	pass
	
func use_action (action, opponent : Character):
	pass
	
func use_reaction (reaction, opponent : Character, action):
	pass
	
func roll_initiative():
	return randf_range(0.5, 1.5)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
