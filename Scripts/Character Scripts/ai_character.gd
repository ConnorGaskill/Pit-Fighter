extends Abstract_Character


@export var controller : AI_Controller

func decide_action() -> void:
	controller.decide_action()
	
func decide_reaction(action : Action) -> void:
	controller.decide_reaction(action)
	
func load_controller() -> void:
	controller.load_move_packages()
	controller.assigned_character = self
