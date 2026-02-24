extends Node

var fullscreen := true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
