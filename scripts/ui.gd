extends Control

@export var menu : ColorRect
@export var terminal_text : RichTextLabel
@export var text : LineEdit
@export var player : CharacterBody2D

var isMenuOpen := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = get_viewport().size
	menu.size = size
	text.size.x = size.x

func use(item: String) -> void:
	for i in player.inventory.items:
		if(i.item_name == item):
			print("Item found")
			i.use_item(player)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("proc_cancel")):
		player.cancel_process()
		closeMenu()
	
func openMenu() -> void:
	if(!isMenuOpen):
		menu.position.y = 0
		isMenuOpen = true

func get_main_folders() -> void:
	var inventory_content = player.inventory.get_folders()
	terminal_text.text += "Folders \n"
	terminal_text.text += "-------\n"
	for item in inventory_content:
		terminal_text.text += "%s %10d \n" % [item, len(player.inventory.items)]
	terminal_text.text += "\n"

func get_folder(folder: String) -> void:
	var arr: Array
	var folder_name: String
	if(folder == "Weapons"):
		arr = player.inventory.weapons
		folder_name = "Weapons"
	elif(folder == "Items"):
		arr = player.inventory.items
		folder_name = "Items"
	elif(folder == "Scripts"):
		arr = player.inventory.scripts
		folder_name = "Scripts"
	else:
		print("no folder")
		return
	
	terminal_text.text += "%s \n" % folder_name
	terminal_text.text += "-------\n"
	for o in arr:
		terminal_text.text += o.item_name
	terminal_text.text += "\n"

func closeMenu() -> void:
	if(isMenuOpen):
		menu.position.y = size.y
		isMenuOpen = false



func _on_line_edit_text_submitted(new_text: String) -> void:
	var text = new_text.split(" ")

	match text[0]:
		# Menu
		"inventory":
			openMenu()
			get_main_folders()
		"ivt":
			openMenu()
			get_main_folders()
		"ls":
			if(len(text) == 1):
				openMenu()
				get_main_folders()
			elif(len(text) == 2):
				openMenu()
				get_folder(text[1])
		"close":
			closeMenu()
		"cls":
			closeMenu()

		# Movement
		"move":
			if(len(text) > 1):
				player.move(text)
			else:
				print("This command needs at least one option")
		"turn":
			if(len(text) > 1):
				player.turn(text)
			else:
				print("This command needs at least one option")

		"attack":
			player.attack()
		"health":
			print(player.health)
		"use":
			use(text[1])
		"open":
			player.open()
		"clear":
			terminal_text.text = ""


		# END
		_:
			print("Invalid command")
