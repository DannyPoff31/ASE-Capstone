class_name Inventory
extends Node

var weapons:= ["fist", "sword"]
var items:= ["potion"]
var scripts:= []


func get_folders() -> Array:
	return [weapons, items, scripts]
