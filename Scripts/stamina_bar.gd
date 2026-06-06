extends ProgressBar

class_name StaminaBar

@export var character : Character


func _ready() -> void:

	if character == null:
		push_error("StaminaBar has no character assigned.")
		return

	max_value = character.max_stamina
	value = character.current_stamina

	character.stamina_changed.connect(update_stamina)


func update_stamina(current_stamina:int, max_stamina:int) -> void:

	max_value = max_stamina
	value = current_stamina
