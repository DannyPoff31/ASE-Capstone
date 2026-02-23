class_name Weapon
extends Node

@export var sprite: AnimatedSprite2D
@export var shape: CollisionShape2D

var damage: int
var cooldown: int


func attack(params: Array) -> void:
	if(len(params) > 1):
		var options = params[1].split("")
		var paramIndex = 2
		if(options[0] == "-"):
			for op in options:
				pass
	else:
		print("")
