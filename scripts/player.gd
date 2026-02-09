extends CharacterBody2D

@export var tiles : Node

var playerPosition

func _ready() -> void:
	playerPosition = tiles.findTile(position)

func move(x, y):
	playerPosition = Vector2(x,y)
	position = tiles.findCoord(playerPosition)
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_down")):
		move(playerPosition.x, playerPosition.y-1)
