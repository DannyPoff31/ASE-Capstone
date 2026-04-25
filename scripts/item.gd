class_name Item
extends Area2D

var item_name : String

func _ready() -> void:
	collision_layer = 2
	collision_mask = 0

func get_item_name() -> String:
	return item_name

func use_item(player : Player) -> void:
	pass
