extends Control

@export var menu : ColorRect
@export var terminal_text : RichTextLabel
@export var script_edit : TextEdit
@export var text : LineEdit
@export var player : CharacterBody2D
@export var inv : Inventory
@onready var command_line = $CommandLine/RichTextLabel
@onready var file = JSON.parse_string(FileAccess.open("res://assets/manuel.json", FileAccess.READ).get_as_text())
@onready var health: RichTextLabel = $Health

var directory: String = "plyr"
var dir_list: Array = ["plyr", "inv"]
var isMenuOpen := false
var is_script_open := false
var script_temp: String = ""

func _ready() -> void:
	player.damaged.connect(health_bar)
	health.text = "health: %s" %player.health

func health_bar(new_health: int) -> void:
	health.text = "health: %s" %new_health

func use(item:= "") -> void: ## rework !!!!
	var ind:= 0
	for i in player.inventory.items:
		if(i.item_name == item):
			i.use_item(player)
			player.inventory.items.remove_at(ind)
			i.queue_free()
		ind += 1

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("proc_cancel")):
		player.cancel_process()
		closeMenu()
	if(event.is_action_pressed("term_return")):
		return_to_terminal()

func return_to_terminal() -> void:
	text.grab_focus()

func openMenu() -> void:
	if(!isMenuOpen):
		menu.visible = true
		isMenuOpen = true

func get_main_folders() -> void:
	var inventory_content = player.inventory.get_folders()
	terminal_text.text += "Folders \n"
	terminal_text.text += "-------\n"
	for item in inventory_content:
		terminal_text.text += "%s %10d \n" % [item, player.inventory.folder_size(item)]
	terminal_text.text += "\n"

func get_folder(folder:= "") -> void:
	var arr: Array
	if(folder == "Weapons"):
		arr = inv.get_all_weapons()
	elif(folder == "Items"):
		arr = inv.get_all_items()
	elif(folder == "Scripts"):
		arr = inv.get_all_rscripts()
	else:
		terminal_text.text += "%s: This folder does not exist\n" % folder
		return
	terminal_text.text += "%s \n" % folder
	terminal_text.text += "-------\n"
	for o in arr:
		terminal_text.text += "%s\n" %o
	terminal_text.text += "\n"

### OPENS THE SCRIPT EDITOR
func cat(scr_name = "") -> void:
	if(scr_name != ""):
		if inv.is_script_available(scr_name): 
			script_edit.text = inv.get_script_by_name(scr_name).get_content()
		script_temp = scr_name
		openMenu()
		script_edit.visible = true
		is_script_open = true
		script_edit.grab_focus()

func save() -> void:
	if(script_temp != ""):
		inv.add_script(RScript.new(script_temp, script_edit.text))
		closeMenu()
		text.grab_focus()

### USES THE SCRIPT
func run(scr = "", param = "") -> void:
	if(param == "-r"): player.repeat = true
	if(inv.is_script_available(scr)):
		player.add_script(inv.get_script_by_name(scr).get_content())

func closeMenu() -> void:
	if(isMenuOpen):
		script_temp = ""
		menu.visible = false
		script_edit.text = ""
		script_edit.visible = false
		is_script_open = false
		isMenuOpen = false

func ls(folder = "") -> void:
	openMenu()
	if(folder == ""):
		get_main_folders()
	else:
		get_folder(folder)
		


func _on_line_edit_text_submitted(new_text: String) -> void:
	var parse_text = new_text.split(" ")

	if(parse_text[0] == "cd"):
		if(parse_text[1] in dir_list):
			directory = parse_text[1]
			command_line.text = "root@player:~/%s$" %directory
			return
	if(parse_text[0] == "man"):
		openMenu()
		if(len(parse_text) == 1): 
			script_edit.text = "%s\n" %parse_text[0]
			script_edit.text += file.list
		elif(parse_text[1] in file.commands): 
			script_edit.text = "%s\n" %parse_text[1]
			script_edit.text += file.commands[parse_text[1]]
		return
	if(directory == "inv" && parse_text[0] != ""):
		var callable = Callable(self, parse_text[0])
		if(len(parse_text) == 1):
			if(callable.is_valid()):
				callable.call()
		elif(len(parse_text) >= 2):
			parse_text.remove_at(0)
			if(callable.is_valid()):
				callable.callv(parse_text)
	elif(directory == "plyr" && parse_text[0] != ""):
		var callable = Callable(player, parse_text[0])
		if(len(parse_text) == 1):
			if(callable.is_valid()):
				callable.call()
		elif(len(parse_text) >= 2):
			parse_text.remove_at(0)
			if(callable.is_valid()):
				callable.callv(parse_text)
