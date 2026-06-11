@abstract

extends Resource

class_name Abstract_Controller

@export var name : String

@export var move_packages : Array[Move_Package]

#var loaded_move_packages : Array[Loaded_Move_Package]

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
	for ka : Action in known_actions:
		print(ka.name, " ", known_actions[ka])
	for kr : Reaction in known_reactions:
		print(kr.name, " ", known_reactions[kr])

	#for wr : Weighted_Reaction in mp.reactions:
		#known_reactions[wr.reaction] = wr.weight + wr.reaction.weight
	
	#for mp : Move_Package in move_packages:
		#for action : String in mp.actions:
			#mp.actions.set(load(action), mp.actions[action])
		#for reaction : String in mp.reactions:
			#mp.reactions.set(load(reaction), mp.reactions[reaction])
	
	#for mp : Loaded_Move_Package in loaded_move_packages:
		#for action : Action in mp.actions:
			#known_actions[action] = mp.actions[action] + action.weight
		#for reaction : Reaction in mp.reactions:
			#known_reactions[reaction] = mp.reactions[reaction] + reaction.weight

#class Loaded_Move_Package:
	#
	#var reactions : Dictionary[Reaction, int]
	#var actions : Dictionary[Action, int]
