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
var is_attacking: bool = false
var is_script: bool = false
var rscript: String

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
	


func take_damage(damage: String) -> void:
	health -= int(damage)
	print(health)
	if(health <= 0):
		die()

func die() -> void:
	print("You Died!")

func attack() -> void:
	is_attacking = true
	hit_box.attack()



func move(params: String) -> void:
	var speed_var = params.split("=")
	var options = speed_var[0].split("")
	
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
					if(params.contains("=")):
						speed = int(speed_var[1])
					else:
						print("Error")
				"q":
					move_state = IDLE
					velocity = Vector2(0,0)

func turn(params: String) -> void:
	var rot_speed_var = params.split("=")
	var options = rot_speed_var[0].split("")
	
	if(options[0] == "-"):
		for op in options:
			match op:
				"l":
					turn_state = LEFT
				"r":
					turn_state = RIGHT
				"s":
					if(params.contains("=")):
						rot_speed = int(rot_speed_var[1])
					else:
						print("Error")
				"q":
					turn_state = IDLE

func cancel_process() -> void:
	move("-q")
	turn("-q")
	is_script = false

func rot_to_vect(rot: float) -> Vector2:
	return Vector2(-sin(rot), cos(rot))

func _physics_process(delta: float) -> void:
	if((move_state == FOREWARD) && !is_attacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation) * SPEED_MULTIPLIER * delta
	if((move_state == LEFT) && !is_attacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation - deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if((move_state == RIGHT) && !is_attacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(90)) * SPEED_MULTIPLIER * delta
	if((move_state == BACK) && !is_attacking):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(180)) * SPEED_MULTIPLIER * delta
	if((move_state == IDLE) && !is_attacking):
		sprite.play("default")
	if((turn_state == RIGHT)):
		sprite.rotation += clamp(rot_speed, 1, max_speed) * delta
	if((turn_state == LEFT)):
		sprite.rotation -= clamp(rot_speed, 1, max_speed) * delta
	move_and_slide()
	if(is_script):
		var arr = rscript.split(";")
		arr.remove_at(len(arr)-1)
		for i in arr:
			if(i.contains(":")):
				var if_text = i.split(":")
				if(call(if_text[0].split("(")[1].split(")")[0])):
					var text = if_text[1].split(" ")
					var callable = Callable(self, text[0])
					if(len(text) == 1):
						if(callable.is_valid()):
							callable.call()
					elif(len(text) >= 2):
						text.remove_at(0)
						if(callable.is_valid()):
							callable.callv(text)
			else:
				var text = i.split(" ")
				var callable = Callable(self, text[0])
				if(len(text) == 1):
					if(callable.is_valid()):
						callable.call()
				elif(len(text) >= 2):
					text.remove_at(0)
					if(callable.is_valid()):
						callable.callv(text)
