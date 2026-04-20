extends Control

@export var menu : ColorRect
@export var terminal_text : RichTextLabel
@export var script_edit : TextEdit
@export var text : LineEdit
@export var player : CharacterBody2D
@export var inv : Inventory
@onready var command_line = $CommandLine/RichTextLabel

var directory: String = "player"
var dir_list: Array = ["player", "inventory"]
var isMenuOpen := false
var is_script_open := false

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
		menu.position.x = 0
		menu.position.y = 0
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
		terminal_text.text += o
	terminal_text.text += "\n"

func new_script() -> void:
	openMenu()
	script_edit.visible = true
	is_script_open = true
	text.release_focus()
	script_edit.grab_focus()

func create_script(script_name = "") -> void:
	if(script_name != ""):
		inv.add_script(RScript.new(script_name, script_edit.text))
		closeMenu()
		text.grab_focus()

func use_script(src = "") -> void:
	if(src != ""):
		player.add_script(inv.get_script_by_name(src).get_content())

func closeMenu() -> void:
	if(isMenuOpen):
		menu.position.y = size.y
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
			command_line.text = "root@player:~/%s" %directory
			return
	if(parse_text[0] == "inv" && len(parse_text) >= 2):
		var callable = Callable(self, parse_text[1])
		if(len(parse_text) == 2):
			if(callable.is_valid()):
				callable.call()
		elif(len(parse_text) >= 3):
			parse_text.remove_at(0)
			parse_text.remove_at(0)
			if(callable.is_valid()):
				callable.callv(parse_text)
	elif(parse_text[0] != ""):
		var callable = Callable(player, parse_text[0])
		if(len(parse_text) == 1):
			if(callable.is_valid()):
				callable.call()
		elif(len(parse_text) >= 2):
			parse_text.remove_at(0)
			if(callable.is_valid()):
				callable.callv(parse_text)

	#match text[0]:
		#### Menu ###
		#"inventory":
			#openMenu()
			#get_main_folders()
		#"ivt":
			#openMenu()
			#get_main_folders()
		#"ls":
			#if(len(text) == 1):
				#openMenu()
				#get_main_folders()
			#elif(len(text) == 2):
				#openMenu()
				#get_folder(text[1])
		#"newScript":
			#openMenu()
			#open_script()
		#"save":
			#if(is_script_open && len(text) == 2):
				#create_script(text[1])
		#"close":
			#closeMenu()
		#"cls":
			#closeMenu()
		#### END MENU ###
#
		#### Movement ###
		#"move":
			#if(len(text) > 1):
				#player.move(text)
			#else:
				#print("This command needs at least one option")
		#"turn":
			#if(len(text) > 1):
				#player.turn(text)
			#else:
				#print("This command needs at least one option")
		#### END Movement ###
#
		#"attack":
			#player.attack()
		#"health":
			#print(player.health)
		#"use":
			#use(text[1])
		#"script":
			#use_script(text[1])
		#"open":
			#player.open()
		#"clear":
			#terminal_text.text = ""
#
		#
		#_:
			#print("Invalid command")
