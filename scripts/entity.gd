class_name Entity
extends CharacterBody2D

@export var sprite : AnimatedSprite2D
const SPEED_MULTIPLIER := 1000

var health: int
var max_speed:= 8
var speed:= 2
var rot_speed:= 1

enum {
	FOREWARD, 
	LEFT,
	RIGHT,
	BACK,
	IDLE,
}

var move_state = IDLE
var turn_state = IDLE

func _ready() -> void:
	pass

func take_damage(damage: int) -> void:
	health - damage
	if(health <= 0):
		die()

func die() -> void:
	pass

func move(params: Array) -> void:
	var options = params[1].split("")
	var paramIndex = 2
	
	if(options[0] == "-"):
		for op in options:
			match op:
				"f":
					move_state = FOREWARD
				"l":
					move_state = LEFT
				"r":
					move_state = RIGHT
				"b":
					move_state = BACK
				"s":
					speed = int(params[paramIndex])
					paramIndex += 1
				"q":
					move_state = IDLE
					velocity = Vector2(0,0)

func turn(params: Array) -> void:
	var options = params[1].split("")
	var paramIndex = 2
	
	if(options[0] == "-"):
		for op in options:
			match op:
				"l":
					turn_state = LEFT
				"r":
					turn_state = RIGHT
				"s":
					rot_speed = int(params[paramIndex])
					paramIndex += 1
				"q":
					turn_state = IDLE

func cancel_process() -> void:
	move(["","-q"])
	turn(["","-q"])

func rot_to_vect(rot: float) -> Vector2:
	return Vector2(-sin(rot), cos(rot))

func _physics_process(delta: float) -> void:
	if(move_state == FOREWARD):
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation) * SPEED_MULTIPLIER * delta
	if(move_state == LEFT):
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation - deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if(move_state == RIGHT):
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if(move_state == BACK):
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(180)) * SPEED_MULTIPLIER * delta
	if(turn_state == LEFT):
		sprite.rotation += clamp(rot_speed, 1, max_speed) * delta
	if(turn_state == RIGHT):
		sprite.rotation -= clamp(rot_speed, 1, max_speed) * delta
	move_and_slide()
