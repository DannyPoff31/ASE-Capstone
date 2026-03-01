class_name HitBox
extends Area2D

@export var collision_shape : CollisionShape2D
var damage : int = 2

func _ready() -> void:
	collision_shape.disabled = true
	collision_layer = 2
	collision_mask = 0
	connect("area_entered", _on_area_entered)

func attack() -> void:
	collision_shape.disabled = false
	owner.attack_sprite.play("fire")

func open() -> void:
	collision_shape.disabled = false
	owner.attack_sprite.play("open")

func _on_area_entered(container: Node) -> void:
	pass
