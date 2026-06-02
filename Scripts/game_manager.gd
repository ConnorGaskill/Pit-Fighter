extends Node2D

signal update_action_buttons
signal update_reaction_buttons(action)
signal action_selected(action)
signal reaction_selected(reaction)
signal process_move(move, target)

@export var player_character : Character

@export var ai_character : Character

var acting_character : Character

var reacting_character : Character

var round_action : Action

var round_reaction : Reaction

var game_over : bool = false

var active_phase : Phases = Phases.START

var process_phase : bool = true

var winner : Character

var winning_move : Abstract_Combat_Move

var target_character : Character

enum Phases {
	START,
	ACTION,
	REACTION,
	COMPARE,
	PROCESS,
	END_STEP
}

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
		Phases.COMPARE:
			decide_action_or_reaction_step()
		Phases.PROCESS:
			process_step()
		Phases.END_STEP:
			end_step()
			

func start() -> void:
	#initiative_check()
	acting_character = ai_character
	reacting_character = player_character
	active_phase = Phases.ACTION
	
func action_phase ():
	process_phase = false
	
	if acting_character.is_player:
		update_action_buttons.emit()
		round_action = await action_selected
		
	else:
		ai_decide_action()
		
	process_phase = true
	active_phase = Phases.REACTION

func reaction_phase ():
	process_phase = false
	if reacting_character.is_player:
		update_reaction_buttons.emit(round_action)
		
		round_reaction = await reaction_selected
	else:
		ai_decide_reaction()
		
	process_phase = true
	active_phase = Phases.COMPARE
	
func decide_action_or_reaction_step():
	process_phase = false
	var action_score : int
	var reaction_score : int
	
	action_score = randi_range(1, 20)
	
	reaction_score = randi_range(1, 20)
	
	if action_score >= reaction_score:
		winning_move = round_action
		target_character = reacting_character
		
	else:
		winning_move = round_reaction
		target_character = acting_character
		
	print("The winning move is: " + winning_move.name)
	
	process_phase = true
	active_phase = Phases.PROCESS
	
func process_step():
	process_phase = false
	process_move.emit(winning_move, target_character)
	process_phase = true
	active_phase = Phases.END_STEP
	
func end_step():
	
	process_phase = false
	
	if player_character.current_hp <= 0 and ai_character.current_hp <=0:
		game_over = true
	elif player_character.current_hp <= 0:
		game_over = true
		winner = ai_character
	elif ai_character.current_hp <= 0:
		game_over = true
		winner = player_character
		
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
		
		var coin_flip : int = randi_range(1,2)
	
		if coin_flip == 1:
			acting_character = player_character
			reacting_character = ai_character
		else:
			acting_character = ai_character
			reacting_character = player_character
		
		process_phase = true
		active_phase = Phases.ACTION
		
func ai_decide_action ():
	round_action = ai_character.known_actions[0]
	print(round_action)
	
func ai_decide_reaction ():
	round_reaction = ai_character.known_reactions[0]
	print(round_reaction.name)
	
func initiative_check():
	var pc_initiative = 0
	var ai_initiative = 0
	var highest_initiative
	var lowest_initiative
	
	while (pc_initiative == ai_initiative) :
		pc_initiative = player_character.roll_initiative()
		ai_initiative = ai_character.roll_initiative()
		
		if (pc_initiative > ai_initiative) :
			highest_initiative = player_character
			lowest_initiative = ai_character
			
		if (pc_initiative < ai_initiative) :
			highest_initiative = ai_character
			lowest_initiative = player_character
			
	acting_character = highest_initiative
	reacting_character = lowest_initiative
	
	
