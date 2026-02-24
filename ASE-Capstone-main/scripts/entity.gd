class_name Entity
extends CharacterBody2D

@export var tiles : Node
@export var sprite : AnimatedSprite2D
@export var dir := Vector2(0, -1)

var pos : Vector2
var weapon : Weapon

enum {
	MOVE, 
	IDLE
}

var state = IDLE

func _ready() -> void:
	pos = tiles.findTile(position)
	position = tiles.findCoord(pos)
	turn(dir)
	tiles.occupyTile(self, pos)

func setPos(value: Vector2) -> void:
	pos = value
	state = MOVE
	print("pso set")

func move(speed: float):
	var targetCoords = tiles.findCoord(pos)
	var temp = targetCoords - position
	print("LOG")
	print(targetCoords)
	print(temp)
	print(position)
	
	if(position.y > (targetCoords.y + .1)):#Vector2(.1, .1))):
		velocity = speed * dir
	elif(position.y < (targetCoords.y - .1)):#Vector2(.1, .1))):
		velocity = speed * -dir
	else:
		state = IDLE
		print("destination reached")

	move_and_slide()

func moveTowards(target: Vector2) -> void:
	pass

func wait() -> void:
	await get_tree().create_timer(1.0).timeout

func entAttk(value: String) -> void:
	print(tiles.layer.get_neighbor_cell(pos, 12))
	

func turn(value: Vector2) -> void:
	dir = value
	
	if(value.x == 1):
		sprite.rotation = deg_to_rad(90)
	elif(value.x == -1):
		sprite.rotation = deg_to_rad(270)
	elif(value.y == 1):
		sprite.rotation = deg_to_rad(180)
	elif(value.y == -1):
		sprite.rotation = deg_to_rad(0)
	else:
		print("X or Y should either be 1 or -1")

func turnRight() -> void:
	if(dir.x == 1):
		turn(Vector2(0,1))
	elif(dir.x == -1):
		turn(Vector2(0,-1))
	elif(dir.y == 1):
		turn(Vector2(-1,0))
	elif(dir.y == -1):
		turn(Vector2(1,0))

func turnLeft() -> void:
	if(dir.x == 1):
		turn(Vector2(0,-1))
	elif(dir.x == -1):
		turn(Vector2(0,1))
	elif(dir.y == 1):
		turn(Vector2(1,0))
	elif(dir.y == -1):
		turn(Vector2(-1,0))
