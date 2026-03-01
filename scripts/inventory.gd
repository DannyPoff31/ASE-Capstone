class_name Inventory
extends Node

var weapons: Array = ["Weapons", "fist", "sword"]
var items: Array = ["Items", "potion"]
var scripts: Array = ["Scripts"]

func _ready() -> void:
	pass

func add_item(item: Item) -> void:
	items.push_back(item)
	print(len(items))

func get_item(i : int) -> Item:
	return items[i]

func get_folders() -> Array:
	return [weapons[0], items[0], scripts[0]]
