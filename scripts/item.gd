class_name Item
extends Area2D

var item_name : String

func _ready() -> void:
	collision_layer = 2
	collision_mask = 0


func use_item(player : Player) -> void:
	pass
