extends Node

@export var layer : TileMapLayer

var ent: Array[Node]
var loc: Array[Vector2]

func _ready() -> void:
	pass

func occupyTile(obj: Node, coord: Vector2) -> void:
	ent.append(obj)
	loc.append(coord)


func findEntityOnTile(coord: Vector2):
	pass
	


func findTile(coord: Vector2) -> Vector2:
	return layer.local_to_map(coord)

func findCoord(tile: Vector2) -> Vector2:
	return layer.map_to_local(tile)
