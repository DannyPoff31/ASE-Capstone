extends Entity
@onready var timer: Timer = $Timer

#func _ready() -> void:
	#setPos(Vector2(0,-2))
func die() -> void:
	queue_free()

func _process(delta: float) -> void:
	attack()
