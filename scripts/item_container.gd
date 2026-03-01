class_name ItemContainer
extends Area2D

var opened: bool = false
var item: Item

func _ready() -> void:
	collision_layer = 0
	collision_mask = 2
