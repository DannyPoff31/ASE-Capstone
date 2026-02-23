extends Entity
@onready var timer: Timer = $Timer

#func _ready() -> void:
	#setPos(Vector2(0,-2))

#func _process(delta: float) -> void:
	#match state:
		#MOVE:
			#move(10)
			#move_and_slide()
		#IDLE:
			#pass
