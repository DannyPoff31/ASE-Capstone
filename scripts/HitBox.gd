class_name HitBox
extends Area2D

@export var collision_shape : CollisionShape2D
var damage : int = 2

func _ready() -> void:
	collision_shape.disabled = true
	collision_layer = 2
	collision_mask = 0

func attack() -> void:
	collision_shape.disabled = false
	owner.attack_sprite.play("fire")
