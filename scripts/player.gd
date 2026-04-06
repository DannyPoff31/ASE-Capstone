class_name Player
extends Entity

@export var inventory:= Node

func open() -> void:
	is_attacking = true
	hit_box.open()

func die() -> void:
	queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	if(is_attacking):
		is_attacking = false
		hit_box.collision_shape.disabled = true
