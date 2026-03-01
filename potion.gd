extends Item

func _ready() -> void:
	super()
	item_name = "health_potion"

func use_item(player : Player) -> void:
	player.health += 5
