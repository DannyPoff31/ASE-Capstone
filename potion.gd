extends Item

func _ready() -> void:
	item_name = "health potion"

func use_item() -> void:
	owner.health += 5
