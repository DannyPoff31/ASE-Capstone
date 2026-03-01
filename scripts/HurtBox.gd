class_name HurtBox
extends Area2D

func _ready() -> void:
	collision_layer = 0
	collision_mask = 2
	connect("area_entered", _on_area_entered)
	connect("area_entered", _on_item_entered)

func _on_item_entered(item: Item) -> void:
	print("Grabbed")
	if(owner.inventory):
		owner.inventory.add_item(item)
	

func _on_area_entered(hit_box: HitBox) -> void:
	owner.take_damage(hit_box.damage)
