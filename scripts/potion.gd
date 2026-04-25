extends Item
var collision: CollisionShape2D
var sprite: AnimatedSprite2D

func _ready() -> void:
	super()
	collision = $CollisionShape2D
	sprite = $AnimatedSprite2D
	item_name = "health_potion"

func use_item(player : Player) -> void:
	player.take_damage("-5")
