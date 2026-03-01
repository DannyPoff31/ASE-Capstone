class_name Entity
extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var attack_sprite : AnimatedSprite2D
@export var hit_box : HitBox
const SPEED_MULTIPLIER : int = 1000

@export var health: int
var max_speed: int = 8
var speed: int = 2
var rot_speed: int = 1
var isAttacking: bool = false

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
	sprite.play("default")

func take_damage(damage: int) -> void:
	health -= damage
	if(health <= 0):
		die()

func die() -> void:
	print("You Died!")

func attack() -> void:
	isAttacking = true
	hit_box.attack()



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
	if((move_state == FOREWARD) && !isAttacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation) * SPEED_MULTIPLIER * delta
	if((move_state == LEFT) && !isAttacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation - deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if((move_state == RIGHT) && !isAttacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if((move_state == BACK) && !isAttacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(180)) * SPEED_MULTIPLIER * delta
	if((move_state ==IDLE) && !isAttacking):
		sprite.play("default")
	if((turn_state == RIGHT) && !isAttacking):
		sprite.rotation += clamp(rot_speed, 1, max_speed) * delta
	if((turn_state == LEFT) && !isAttacking):
		sprite.rotation -= clamp(rot_speed, 1, max_speed) * delta
	move_and_slide()
