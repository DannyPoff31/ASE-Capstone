class_name Player
extends Entity

@export var inventory:= Node


func die() -> void:
	queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	if(isAttacking):
		isAttacking = false
		hit_box.collision_shape.disabled = true
