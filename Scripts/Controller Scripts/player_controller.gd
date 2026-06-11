extends Abstract_Controller

class_name Player_Controller

var button_manager : CombatButtonManager = CombatButtonManager.new()

func decide_reaction(action : Action) -> void:
	var reactions : Dictionary[Abstract_Combat_Move, bool]

	for rm : Reaction in action.related_moves:
		if rm in known_reactions:
			if rm.tags.has(Enums.TagType.STAMINA_COST):
				if rm.tags[Enums.TagType.STAMINA_COST] > assigned_character.current_stamina:
					reactions[rm] = false
		reactions[rm] = true

	button_manager.decide_move(reactions)

func decide_action() -> void:
	var actions : Dictionary[Abstract_Combat_Move, bool]
	
	for action : Action in known_actions:
		if action.tags.has(Enums.TagType.STAMINA_COST):
			if action.tags[Enums.TagType.STAMINA_COST] > assigned_character.current_stamina:
				actions[action] = false
			else:
				actions[action] = true
		else:
			actions[action] = true

	button_manager.decide_move(actions)
