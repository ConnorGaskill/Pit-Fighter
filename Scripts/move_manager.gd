extends Node

func _ready() -> void:

	GameManager.process_move.connect(apply_move)

func apply_move(move : Abstract_Combat_Move, target : Character) -> void:
	print("Processed move: " + move.name)
	var damage_on_stack : int = 0
	
	# apply tags to stack

	if move.tags.has(Enums.TagType.DAMAGE):
		damage_on_stack = move.tags[Enums.TagType.DAMAGE]

	if move.tags.has(Enums.TagType.STUN):
		target.add_status(Enums.TagType.STUN, move.tags[Enums.TagType.STUN])
		
	# process effects on stack
		
	if damage_on_stack > 0:
		target.change_hp(0 - damage_on_stack)
		
	#GameManager.process_phase.emit(true)
	return
