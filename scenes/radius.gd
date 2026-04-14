extends Area2D
@export var shape: CollisionShape2D
var in_range:= false

func _ready() -> void:
	collision_layer = 0
	collision_mask = 1

func _physics_process(delta: float) -> void:
	if(get_overlapping_areas().size() > 1):
		in_range = true
	else:
		in_range = false
