extends Node

@export var layer : TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(layer.local_to_map(event.position))


func findTile(coord: Vector2) -> Vector2:
	return layer.local_to_map(coord)

func findCoord(tile: Vector2) -> Vector2:
	return layer.map_to_local(tile)
