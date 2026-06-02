extends Resource

class_name Tag

enum Tag_Type {
	DAMAGE,
	STUN
}

@export var label : Tag_Type
@export var qty : int = 0
