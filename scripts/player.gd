class_name Player
extends Entity

@export var inventory:= Node
var heath = 10



func die() -> void:
	get_tree().paused
	#get_tree().root.add_child()
