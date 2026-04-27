extends Node2D

@export var player_character : Character

@export var ai_character : Character

var current_character : Character

var acting_character : Character

var game_over : bool = false

func start_combat ():
	var pc_initiative = 0
	var ai_initiative = 0
	var highest_initiative
	
	while (pc_initiative == ai_initiative) :
		pc_initiative = player_character.roll_initiative()
		ai_initiative = ai_character.roll_initiative()
		if (pc_initiative > ai_initiative) :
			highest_initiative = player_character
		if (pc_initiative < ai_initiative) :
			highest_initiative = ai_character
			
	acting_character = highest_initiative
	
	

func next_turn ():
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
		next_turn()
		
		
func player_use_action (action):
	if player_character != current_character:
		return
	player_character.use_action(action, ai_character)
	# disable player ui
	await get_tree().create_timer(0.5).timeout
	next_turn()
	
func player_use_reaction (action):
	if player_character != current_character:
		return
	player_character.use_action(action, ai_character)
	# disable player ui
	await get_tree().create_timer(0.5).timeout
	next_turn()
		
func ai_decide_combat_action ():
	pass
		
			
			
