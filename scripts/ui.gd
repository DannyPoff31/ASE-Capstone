extends Control

@export var menu : ColorRect
@export var text : LineEdit
@export var player : CharacterBody2D

var isMenuOpen := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = get_viewport().size
	menu.size = size
	text.size.x = size.x



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func openMenu() -> void:
	if(!isMenuOpen):
		menu.position.y = 0
		isMenuOpen = true

func closeMenu() -> void:
	if(isMenuOpen):
		menu.position.y = size.y
		isMenuOpen = false

func moveDir(dir) -> void:
	if(dir == "c"):
		while(true):
			var move = player.pos + player.dir
			player.move(move)
			await get_tree().create_timer(1.0).timeout
	elif(dir == "r"):
		var move : Vector2
		move.x = player.pos.x - player.dir.y
		move.y = player.pos.y + player.dir.x
		
		player.setPos(move)
		#player.move(move, 1)
	elif(dir == "l"):
		var move : Vector2
		move.x = player.pos.x + player.dir.y
		move.y = player.pos.y - player.dir.x
		
		player.setPos(move)
	elif(dir == "b"):
		var move = player.pos - player.dir
		player.setPos(move)
	else:
		print("Invalid modifyier to move command")

func turnDir(dir) -> void:
	if(dir == "l"):
		player.turnLeft()
	elif(dir == "r"):
		player.turnRight()
	else:
		print("Invalid modifier to turn command")

func _on_line_edit_text_submitted(new_text: String) -> void:
	var text = new_text.replace(" ", "")
	text = text.split("-")

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
			if(len(text) == 1):
				var move = player.pos + player.dir
				player.setPos(move)
			elif(len(text) == 2):
				moveDir(text[1])
			else:
				print("Incorrect format for command")
		"turn":
			if(len(text) == 2):
				turnDir(text[1])
			else:
				print("Incorrect format for command")

		"attack":
			player.entAttk(text[0])


		# END
		_:
			print("Invalid command")
