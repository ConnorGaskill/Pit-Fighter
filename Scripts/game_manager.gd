class_name GameManager extends Node2D

signal process_move(source_character : Abstract_Character, target_character : Abstract_Character, 
winning_move : Abstract_Combat_Move)

@onready var player_1 : Abstract_Character = %Player_1

@onready var player_2 : Abstract_Character = %Player_2

var acting_character : Abstract_Character

var reacting_character : Abstract_Character

var round_action : Action

var round_reaction : Reaction

var game_over : bool = false

var active_phase : Phases = Phases.START

var process_phase : bool = true

var winner : Abstract_Character

var winning_move : Abstract_Combat_Move

var target_character : Abstract_Character

var source_character : Abstract_Character

static var Instance : GameManager

enum Phases {
	START,
	ACTION,
	REACTION,
	PLAYER_1_INPUT,
	PLAYER_2_INPUT,
	COMPARE,
	PROCESS,
	END_STEP
}

func _init() -> void:
	Instance = self

func _physics_process(delta: float) -> void:
	if !process_phase:
		return
	
	match active_phase:
		Phases.START:
			start()
		Phases.ACTION:
			action_phase()
		Phases.REACTION:
			reaction_phase()
		Phases.PLAYER_1_INPUT:
			pass # show_player_1_buttons(Phases.ACTION || Phases.REACTION)
		Phases.PLAYER_2_INPUT:
			pass # show_player_2_buttons(Phases.ACTION || Phases.REACTION)
		Phases.COMPARE:
			decide_action_or_reaction_step()
		Phases.PROCESS:
			process_step()
		Phases.END_STEP:
			end_step()
			

func start() -> void:
	#set_position.emit(ai_character, player_character, Position_Manager.Position.STANDING)
	_set_acting_reacting()
	active_phase = Phases.ACTION
	
func action_phase () -> void:
	process_phase = false
	
	#round_action = acting_character.decide_action()
	
	print("Decided Action (GM): ", round_action)
	
	#active_phase = Phases.REACTION
	#process_phase = true

func reaction_phase () -> void:
	process_phase = false
	
	reacting_character.decide_reaction(round_action)
	
	process_phase = true
	active_phase = Phases.COMPARE
	
func decide_action_or_reaction_step() -> void:
	process_phase = false
	var action_score : int
	var reaction_score : int
	
	action_score = randi_range(1, 20)
	
	reaction_score = randi_range(1, 20)
	
	if action_score >= reaction_score:
		winning_move = round_action
		target_character = reacting_character
		source_character = acting_character
		
	else:
		winning_move = round_reaction
		target_character = acting_character
		source_character = reacting_character
		
	print("The winning move is: " + winning_move.name)
	
	process_phase = true
	active_phase = Phases.PROCESS
	
func process_step() -> void:
	process_phase = false
	process_move.emit(source_character, target_character, winning_move)
	process_phase = true
	active_phase = Phases.END_STEP
	
func end_step() -> void:
	
	process_phase = false
	
	if player_1.current_hp <= 0 and player_2.current_hp <=0:
		game_over = true
	elif player_1.current_hp <= 0:
		game_over = true
		winner = player_2
	elif player_2.current_hp <= 0:
		game_over = true
		winner = player_1
		
	round_action = null
	round_reaction = null
	winning_move = null
	target_character = null
	
	if game_over:
		if winner != null:
			print(winner.character_name + " has won!")
			
		else:
			print("It was a tie")
			
		process_phase = false
		return
	else:
		
		_set_acting_reacting()
		process_phase = true
		active_phase = Phases.ACTION
		
	
func _flip_coin() -> int:
	return randi_range(1,2)
	
func _pick_character() -> Abstract_Character:
	if _flip_coin() == 1:
		return player_1
	else:
		return player_2
		
func _set_acting_reacting() -> void:
	if _flip_coin() == 1:
		acting_character = player_1
		reacting_character = player_2
	else:
		acting_character = player_2
		reacting_character = player_1
