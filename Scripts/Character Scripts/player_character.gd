extends Abstract_Character

class_name Player_Character

@export var controller : Player_Controller

func decide_action() -> void:
	controller.decide_action()
	
func decide_reaction(action : Action) -> void:
	controller.decide_reaction(action)
	
func load_resources() -> void:
	%Control.add_child(controller.button_manager)
	controller.button_manager.position = sprite.position + Vector2(200, -128)
	
func load_controller() -> void:
	print("controller loaded", controller.name)
	controller.load_move_packages()
	controller.assigned_character = self
	controller.button_manager.assigned_player = self
