class_name HurtBox
extends Area2D

func _ready() -> void:
	collision_layer = 1
	collision_mask = 2
	connect("area_entered", _on_area_entered)

func _on_area_entered(area) -> void:
	if(area is HitBox):
		owner.take_damage(area.damage)
	elif(area is Item):
		if(owner is Player):
			owner.inventory.add_item(area)
			area.collision.disabled = true
			area.sprite.visible = false
