extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(reswtart)

func reswtart() -> void:
	get_tree().quit()
	printerr("Get fucked, fix it yourself")
