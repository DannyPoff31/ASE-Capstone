extends Node

var fullscreen := true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	get_viewport().size = DisplayServer.screen_get_size()
	$Enemy.died.connect(on_died)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func on_died() -> void:
	print("you win")

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed('quit')):
		get_tree().quit()
	if(event.is_action_pressed("fullscreen")):
		if(fullscreen):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = true

func _physics_process(delta: float) -> void:
	pass
