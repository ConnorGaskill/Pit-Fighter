@abstract

extends Resource

class_name Abstract_Controller

@export var name : String

@export var move_packages : Array[Move_Package]

var assigned_character : Abstract_Character

var known_reactions : Dictionary[Reaction, int]

var known_actions : Dictionary[Action, int]

func decide_reaction(action : Action) -> void:
	pass

func decide_action() -> void:
	pass

func load_move_packages() -> void:
	
	for mp : Move_Package in move_packages:
		for wa : Weighted_Action in mp.actions:
			known_actions[wa.action] = wa.weight + wa.action.weight
		for wr : Weighted_Reaction in mp.reactions:
			known_reactions[wr.reaction] = wr.weight + wr.reaction.weight
