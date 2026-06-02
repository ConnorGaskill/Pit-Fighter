extends ProgressBar

class_name HealthBar

@export var character : Character


func _ready() -> void:

	if character == null:
		push_error("HealthBar has no character assigned.")
		return

	max_value = character.max_hp
	value = character.current_hp

	character.hp_changed.connect(update_health)


func update_health(current_hp:int, max_hp:int) -> void:

	max_value = max_hp
	value = current_hp
