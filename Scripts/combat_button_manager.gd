extends VBoxContainer

class_name CombatButtonManager

@onready var button_container : VBoxContainer = self


func _ready() -> void:

	GameManager.update_action_buttons.connect(show_action_buttons)

	GameManager.update_reaction_buttons.connect(show_reaction_buttons)
	
func show_action_buttons() -> void:

	clear_buttons()
	
	for action in GameManager.player_character.known_actions:

		var button := Button.new()

		button.text = action.name

		button_container.add_child(button)

		button.pressed.connect(
			func():
				clear_buttons()
				print("Action selected: ", action.name)		
				GameManager.action_selected.emit(action))
				
func show_reaction_buttons(action : Action) -> void:
	
	clear_buttons()
	
	for rm in action.related_moves:
		for kr in GameManager.player_character.known_reactions:
			if rm == kr.name:
				var button := Button.new()

				button.text = kr.move_name

				button_container.add_child(button)

				button.pressed.connect(
				func():
					clear_buttons()
					GameManager.reaction_selected.emit(kr))
				break
		
func clear_buttons() -> void:
	for child in button_container.get_children():
		child.queue_free()
	
