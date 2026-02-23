class_name Entity
extends CharacterBody2D

const weapons: PackedScene = preload("res://scenes/weapon.tscn")

@export var tiles : Node
@export var sprite : AnimatedSprite2D
@export var max_speed := 8
@export var weapon : Weapon
var rot_speed := 1
var speed := 2
var destination: Vector2

const SPEED_MODIFIER = 1000

var move_state = IDLE
var turn_state = IDLE

enum {
	MOVE, 
	LEFT,
	RIGHT,
	BACK,
	IDLE
}

func _ready() -> void:
	pass
	# weapon = weapons.instantiate()

func turn(params: Array) -> void:
	var options = params[1].split("")
	var paramIndex = 2
	if(options[0] == "-"):
		for op in options:
			if(op == "l"): # rotates the player left
				turn_state = LEFT
			if(op == "r"): # rotates the player right
				turn_state = RIGHT
			if(op == "s"): # modifies rotation speed
				rot_speed = int(params[paramIndex])
				paramIndex + 1
			if(op == "t"):
				rot_speed = params[paramIndex]
				paramIndex + 1
			if(op == "q"):
				turn_state = IDLE
	else:
		print("error: comand options begin with a \"-\"")

func move(params: Array) -> void:
	var options = params[1].split("")
	var paramIndex = 2
	
	move_state = MOVE
	if(options[0] == "-"):
		for op in options:
			if(op == "l"): 
				move_state = LEFT
			if(op == "r"):
				move_state = RIGHT
			if(op == "b"):
				move_state = BACK
			if(op == "s"):
				speed = int(params[paramIndex])
				paramIndex + 1
			if(op == "t"):
				destination = position + (int(params[paramIndex]) * getVectRot(sprite.rotation))
				print("destination set: ", destination, " | current position: ", position)
				paramIndex + 1
			if(op == "q"):
				move_state = IDLE
				velocity = Vector2(0, 0)
	else:
		print("error: comand options begin with a \"-\"")

func _physics_process(delta: float) -> void:
	
	if(turn_state == LEFT):
		sprite.rotation += clamp(-rot_speed, 1, 5) * delta
	if(turn_state == RIGHT):
		sprite.rotation += clamp(rot_speed, 1, 5) * delta
	if(move_state == MOVE):
		velocity = clamp(speed, 1, max_speed) * SPEED_MODIFIER * getVectRot(sprite.rotation) * delta
	if(move_state == LEFT):
		velocity = clamp(speed, 1, max_speed) * SPEED_MODIFIER * getVectRot(sprite.rotation - deg_to_rad(90)) * delta
	if(move_state == RIGHT):
		velocity = clamp(speed, 1, max_speed) * SPEED_MODIFIER * getVectRot(sprite.rotation + deg_to_rad(90)) * delta
	if(move_state == BACK):
		velocity = clamp(speed, 1, max_speed) * SPEED_MODIFIER * getVectRot(sprite.rotation + deg_to_rad(180)) * delta
	
	# Might implement a way to move a given amount of space
	#if(position > destination - Vector2(-1, -1) && position < destination + Vector2(1, 1)):
		#print("desitnaiton reached")
		#move_state == IDLE
	
	
	move_and_slide()

# Gets the vector of a given degree
func getVectRot(rot: float) -> Vector2:
	return Vector2(-sin(rot), cos(rot))
