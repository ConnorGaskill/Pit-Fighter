extends Node2D

signal update_action_buttons
signal update_reaction_buttons()
signal action_selected(action)
signal reaction_selected(reaction)

var player_character : Character

var ai_character : Character

var current_character : Character

var acting_character : Character

var reacting_character : Character

var round_action : Action

var round_reaction : Reaction

var game_over : bool = false

var active_phase : Phases = Phases.START

var process_phase : bool = true

enum Phases {
	START,
	ACTION,
	REACTION,
	COMPARE,
	RESULT,
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
	process_phase = false
	#initiative_check()
	acting_character = player_character
	#active_phase = Phases.ACTION
	
func action_phase ():
	if acting_character.is_player:
		update_action_buttons.emit()
		
		round_action = await action_selected
		
	else:
		ai_decide_action()
		
	active_phase = Phases.REACTION

func reaction_phase ():
	if current_character.is_player:
		update_reaction_buttons.emit()
		
		round_reaction = await reaction_selected
	else:
		ai_decide_reaction()
		
	active_phase = Phases.COMPARE
	
func decide_action_or_reaction_step():
	var round_action_score : int
	
	
	
func process_step():
	pass
	
func end_step():
	if game_over:
		return
		
	if current_character != null:
		current_character.end_turn()
		
	if current_character == ai_character or current_character == null:
		current_character = player_character
		
	else:
		current_character = ai_character
	current_character.begin_turn()
	
	if current_character.is_player:
		pass
		# enable and set ui
		
	else:
		#disable player ui
		var wait_time = randf_range(0.5, 1.5)
		await get_tree().create_timer(wait_time).timeout
		# cast combat action
		await get_tree().create_timer(0.5).timeout
		#next_turn()
		
#func use_action (action):
	#if player_character == current_character:
		#player_character.use_action(action, ai_character)
		#await get_tree().create_timer(0.5).timeout
		## disable player ui
	#else:
		## disable player ui
		#ai_character.use_action(ai_decide_action(), player_character)
		#await get_tree().create_timer(0.5).timeout
	#await get_tree().create_timer(0.5).timeout
	#next_turn()
	
func player_use_reaction (action):
	if player_character != current_character:
		return
	player_character.use_action(action, ai_character)
	# disable player ui
	await get_tree().create_timer(0.5).timeout
	#next_turn()
		
func ai_decide_action ():
	pass
	
func ai_decide_reaction ():
	pass
	
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
	
	
