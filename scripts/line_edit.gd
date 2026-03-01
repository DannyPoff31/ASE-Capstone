extends LineEdit

var history = []
var index = -1
const MAX_HISTORY = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()


func _on_text_submitted(new_text: String) -> void:
	history.push_front(text)
	if(len(history) > 10):
		history.pop_at(10)
	index = -1
	clear()

func _on_gui_input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_up")):
		get_viewport().set_input_as_handled() # removes a default action that causes issues
		if(index <= MAX_HISTORY && index < (len(history)-1)):
			index += 1
			text = history[index]
			caret_column = len(text)
	if(event.is_action_pressed("ui_down")):
		get_viewport().set_input_as_handled() # removes a default action that causes issues
		if(index > 0):
			index -= 1
			text = history[index]
			caret_column = len(text)
		else:
			clear()
