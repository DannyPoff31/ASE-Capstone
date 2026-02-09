extends Control

@export var menu : ColorRect
@export var text : LineEdit
@export var parent : CharacterBody2D

var isMenuOpen := false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = get_viewport().size
	menu.size = size
	menu.position.y = size.y
	text.size.x = size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func toggleMenu() -> void:
	if(isMenuOpen):
		menu.position.y = size.y
		isMenuOpen = false
	else:
		menu.position.y = 0
		isMenuOpen = true


func _on_line_edit_text_submitted(new_text: String) -> void:
	if(new_text == "inventory"):
		toggleMenu()
