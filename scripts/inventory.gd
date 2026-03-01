class_name Inventory
extends Node

var weapons: Array = []
var items: Array = []
var scripts: Array = []

func _ready() -> void:
	pass

func add_item(item: Item) -> void:
	items.push_back(item)
	print(len(items))

func get_item(i : int) -> Item:
	return items[i]

func get_folders() -> Array:
	return ["Weapons", "Items", "Scripts"]
