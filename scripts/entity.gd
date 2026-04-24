class_name Entity
extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $Sprite
@onready var attack_sprite : AnimatedSprite2D = $Sprite/HitBox/AnimatedSprite2D
@onready var hit_box : HitBox = $Sprite/HitBox
@onready var radius: Area2D = $Sprite/Radius
const SPEED_MULTIPLIER : int = 1000

@export var start_dir: float = 0.0
@export var health: int
var max_speed: int = 10
var speed: int = 2
var rot_speed: int = 1
var is_attacking: bool = false
var repeat: bool = false
var is_rscript: bool = false
var rscript: Array
var rscript_indx:= 0
var is_cscript: bool = false
var cscript: Array

var can_move:= true
var can_attack:= true
var is_colliding: bool = false

var target_rotation: float = 0.0
var target_tile: Vector2 = Vector2(0, 0)

enum {
	FOREWARD, 
	LEFT,
	RIGHT,
	BACK,
	IDLE,
}

var move_state = IDLE
var turn_state = IDLE

func truer() -> bool:
	return true

func _ready() -> void:
	sprite.play("default")
	sprite.rotation = deg_to_rad(start_dir)

func hit_wall() -> bool:
	return is_colliding

func in_range() -> bool:
	if(radius):
		return radius.in_range
	return false

func ch_range(range_size: String) -> void:
	if radius:
		radius.shape.shape.set_radius(int(range_size))
func take_damage(damage: String) -> void:
	health -= int(damage)
	if(health <= 0):
		die()

func die() -> void:
	print("You Died!")

func attack() -> void:
	is_attacking = true
	hit_box.attack()
	get_tree().create_timer(1.5).timeout.connect(func(): is_attacking = false)

func add_script(scr:= "") -> void:
	if(scr != ""):
		if(scr.contains(":")):
			cscript = scr.split(";")
			cscript.remove_at(len(cscript)-1)
			is_cscript = true
		else:
			rscript = scr.split(";")
			rscript.remove_at(len(rscript)-1)
			is_rscript = true

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

func dash(direction:= "-f") -> void:
	if(direction != ""):
		if(can_move):
			can_move = false
			target_tile = position + (abs(rot_to_vect(sprite.rotation)) * 64)
			move("%ss=10" % direction)
			get_tree().create_timer(0.25).timeout.connect(func(): dash_end())

func dash_end() -> void:
	can_move = true
	move("-qs=2")

func walk(direction:= "-f") -> void:
	if(direction != ""):
		if(can_move):
			can_move = false
			target_tile = position + (abs(rot_to_vect(sprite.rotation)) * 128)
			move("%ss=5" % direction)
			get_tree().create_timer(1).timeout.connect(func(): walk_end())

func walk_end() -> void:
	can_move = true
	move("-qs=2")

func turn_l() -> void:
	if(can_move):
		can_move = false
		target_rotation = sprite.rotation - deg_to_rad(90)
		turn("-ls=4")
		get_tree().create_timer(.5).timeout.connect(func(): turn_end())
		
func turn_r() -> void:
	if(can_move):
		can_move = false
		target_rotation = sprite.rotation + deg_to_rad(90)  # Set target to 90 degrees left
		turn("-rs=4")
		get_tree().create_timer(.5).timeout.connect(func(): turn_end())

func turn_end() -> void:
	can_move = true
	turn("-qs=2")

func circle(direction:= "") -> void:
	if(direction != "" && direction != "-b" && direction != "-f"):
		var invert_dir: String
		if(direction == "-r"):
			invert_dir = "-l"
			target_rotation = sprite.rotation - deg_to_rad(90)
		elif(direction == "-l"):
			invert_dir = "-r"
			target_rotation = sprite.rotation + deg_to_rad(90)
		if(can_move):
			can_move = false
			move("%ss=5" % direction)
			turn("%ss=2" % invert_dir)
			get_tree().create_timer(.78).timeout.connect(func(): circle_end())

func circle_end() -> void:
	can_move = true
	move("-qs=2")
	turn("-qs=1")

func retreat() -> void:
	can_move = false
	target_tile = position - (abs(rot_to_vect(sprite.rotation)) * 128)
	move("-bs=10")
	get_tree().create_timer(1.0).timeout.connect(func(): retreat_end())

func retreat_end() -> void:
	can_move = true
	move("-qs=2")

func cancel_process() -> void:
	move("-q")
	turn("-q")
	repeat = false
	is_rscript = false
	is_cscript = false

func rot_to_vect(rot: float) -> Vector2:
	return Vector2(-sin(rot), cos(rot))

func _physics_process(delta: float) -> void:
	if((move_state == FOREWARD)):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation) * SPEED_MULTIPLIER * delta
		if position >= target_tile:
			position = target_tile
			move_state = IDLE
	if((move_state == LEFT)):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation - deg_to_rad(90)) * SPEED_MULTIPLIER * delta
		if position <= target_tile:
			position = target_tile
			move_state = IDLE
	if((move_state == RIGHT)):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(90)) * SPEED_MULTIPLIER * delta
		if position >= target_tile:
			position = target_tile
			move_state = IDLE
	if((move_state == BACK)):
		sprite.play("walk")
		velocity = clamp(speed, 1, max_speed) * rot_to_vect(sprite.rotation + deg_to_rad(180)) * SPEED_MULTIPLIER * delta
		if position <= target_tile:
			position = target_tile
			move_state = IDLE
	if((move_state == IDLE)):
		velocity = Vector2(0,0)
		sprite.play("default")
	if((turn_state == RIGHT)):
		sprite.rotation += clamp(rot_speed, 1, max_speed) * delta
		if sprite.rotation >= target_rotation:
			sprite.rotation = target_rotation
			turn_state = IDLE
	if((turn_state == LEFT)):
		sprite.rotation -= clamp(rot_speed, 1, max_speed) * delta
		if sprite.rotation <= target_rotation:
			sprite.rotation = target_rotation
			turn_state = IDLE
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider is TileMapLayer:
			velocity = -(velocity / 2)
			move_state = IDLE
			is_colliding = true
	else:
		is_colliding = false
	move_and_slide()

	if(is_rscript):
		if(can_move && !is_attacking):
			var text = rscript[rscript_indx].trim_prefix(" ").split(" ")
			var callable = Callable(self, text[0])
			if(len(text) == 1):
				if(callable.is_valid()):
					callable.call()
					rscript_indx += 1
			elif(len(text) >= 2):
				text.remove_at(0)
				if(callable.is_valid()):
					callable.callv(text)
					rscript_indx += 1
		if(rscript_indx >= len(rscript)):
			if(!repeat):
				is_rscript = false
				rscript_indx = 0
			else:
				rscript_indx = 0
	if(is_cscript):
		for i in cscript:
			var if_text = i.split("(")[1].split(")")[0]
			var if_not = false
			if "!" in if_text:
				if_text = if_text.split("!")[1]
				if_not = true
			var text = i.split(":")[1].split(" ")
			var if_callable = Callable(self, if_text)
			var callable = Callable(self, text[0])
			if(if_callable.call() != if_not): 
				if(len(text) == 1):
					if(callable.is_valid()):
						callable.call()
				elif(len(text) >= 2):
					text.remove_at(0)
					if(callable.is_valid()):
						callable.callv(text)
