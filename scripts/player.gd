class_name Player
extends Entity

func _process(delta: float) -> void:
	match state:
		MOVE:
			move(10)
			move_and_slide()
		IDLE:
			pass
