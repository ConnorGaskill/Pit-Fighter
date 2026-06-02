@abstract
class_name Abstract_Combat_Move

extends Resource

#const TagType = preload("res://Scripts/Combat Constants/tag_type.gd")
#const RelatedMove = preload("res://Scripts/Combat Constants/related_move.gd")

@export var name : String

@export var related_moves : Array[String]

#@export var tags : Dictionary[TagType.Type, int]

@export var tags : Dictionary[String, int]
