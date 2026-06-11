extends Abstract_Character

class_name Player_Character

@export var controller : Player_Controller
	
func load_resources() -> void:
	%Control.add_child(controller.button_manager)
func load_controller() -> void:
	print("controller loaded", controller.name)
	controller.load_move_packages()
	controller.assigned_character = self
