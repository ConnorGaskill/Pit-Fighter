extends Node2D

class_name Abstract_Character

signal hp_changed(current_hp:int, max_hp:int)
signal stamina_changed(current_stamina : int, max_stamina : int)

@export var position_x : int

@export var position_y : int

@export var max_hp : int

@export var current_hp : int

@export var max_stamina : int

@export var current_stamina : int

@export var max_instinct : int

@export var current_instinct : int 

var sprite : Sprite2D

@export var statuses : Dictionary[String, int]

@export var character_name : String

@export var sprite_texture : GradientTexture2D

func roll_initiative() -> int:
	return randf_range(0, 20)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_controller()
	load_sprite()
	load_resources()
	
func send_move(move : Abstract_Combat_Move) -> void:
	if move is Action:
		#GameManager.Instance.round_action = move
		print("OwO ", move.name)
		GameManager.Instance.action_selected.emit(move as Action)
	
	if move is Reaction:
		
		print("uwu ",move.name)
		#GameManager.Instance.round_reaction = move
		GameManager.Instance.reaction_selected.emit(move as Reaction)
	
	#print("Send Move Type: ", ProjectSettings.get_global_class_list())

	
func decide_action() -> void:
	pass
	
func decide_reaction(action : Action) -> void:
	pass
	
func load_controller() -> void:
	pass

func load_resources() -> void:
	pass

func load_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	sprite.position = Vector2(0, 358)
	sprite.offset = Vector2(0, -32)
	
	add_child(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_stamina(amount : int) -> void:
	
	current_stamina += amount
	current_stamina = clamp(current_stamina, 0, max_stamina)
	
	stamina_changed.emit(current_stamina, max_stamina)

func change_hp(amount:int) -> void:

	current_hp += amount
	current_hp = clamp(current_hp, 0, max_hp)

	hp_changed.emit(current_hp, max_hp)

func _exit_tree() -> void:
	print("GARBAGE")
