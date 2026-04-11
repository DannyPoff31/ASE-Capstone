class_name Inventory
extends Node

const Scripts = preload("res://scripts/scripts.gd")

var weapons: Array = []
var items: Array = []
var scripts: Array = []

func _ready() -> void:
	scripts.push_back(Scripts.new("something", "if(truer):attack;"))
	scripts.push_back(Scripts.new("test", "move -f;turn -rs=1;"))

### SETTERS ###
func add_weapons(weapon: Weapon) -> void:
	weapons.push_back(weapon)

func add_item(item: Item) -> void:
	items.push_back(item)

func add_script(script: RScript):
	scripts.push_back(script)
### END SETTERS ###

### GETTERS ###
func get_weapon(i : int) -> Weapon:
	return weapons[i]

func get_all_weapons() -> Array:
	var weapon_names:= []
	for i in weapons:
		weapon_names.push_back(i.weapon_name)
	return weapon_names

func get_item(i : int) -> Item:
	return items[i]

func get_all_items() -> Array:
	var item_names:= []
	for i in items:
		item_names.push_back(i.item_name)
	return item_names

func get_rscript(i : int) -> RScript:
	return scripts[i]

func get_script_by_name(n : String) -> RScript:
	var rscript : RScript
	for i in scripts:
		if(n == i.script_name):
			rscript = i
			break
	return rscript

func get_all_rscripts() -> Array:
	var script_names:= []
	for i in scripts:
		script_names.push_back(i.script_name)
	return script_names

func folder_size(folder) -> int:
	if(folder == "Weapons"):
		return len(weapons)
	if(folder == "Items"):
		return len(items)
	if(folder == "Scripts"):
		return len(scripts)
	return -1

func get_folders() -> Array:
	return ["Weapons", "Items", "Scripts"]
### END GETTERS ###
