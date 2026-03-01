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

func use() -> void:
	print(player.inventory.get_item(2))

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("proc_cancel")):
		player.cancel_process()
		closeMenu()
	
func openMenu() -> void:
	if(!isMenuOpen):
		menu.position.y = 0
		isMenuOpen = true
		var inventory_content = player.inventory.get_folders()
		for item in inventory_content:
			terminal_text.text += "%s %10d \n" % [item, len(player.inventory.items)]
		text.release_focus()
		text.editable = false
		

func closeMenu() -> void:
	if(isMenuOpen):
		menu.position.y = size.y
		isMenuOpen = false
		text.editable = true
		text.grab_focus()


func _on_line_edit_text_submitted(new_text: String) -> void:
	var text = new_text.split(" ")

	match text[0]:
		# Menu
		"inventory":
			openMenu()
		"ivt":
			openMenu()
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
			use()


		# END
		_:
			print("Invalid command")
