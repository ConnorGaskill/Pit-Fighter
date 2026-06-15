extends Abstract_Controller

class_name AI_Controller

@export var variance : int

func roll_variance() -> int:
	return randi_range(1, variance)

func decide_action() -> void:

	var possible_choices : Dictionary[Action, int] = known_actions

	for action : Action in possible_choices:
		possible_choices[action] += roll_variance()
	
	assigned_character.send_move(possible_choices.find_key(
		possible_choices.values().max()))

func decide_reaction(action : Action) -> void:
	
	var possible_choices : Dictionary[Reaction, int]
	
	
	for rm : Reaction in action.related_moves:
		if rm in known_reactions:
			if rm.tags.has(Enums.TagType.STAMINA_COST):
				if rm.tags[Enums.TagType.STAMINA_COST] <= assigned_character.current_stamina:
					possible_choices[rm] = known_reactions[rm] + roll_variance()
			else:
				possible_choices[rm] = known_reactions[rm] + roll_variance()

	assigned_character.send_move(possible_choices.find_key(
		possible_choices.values().max()))
