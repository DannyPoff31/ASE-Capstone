extends Area2D
@onready var parent: Entity = $"../.."
@onready var shape: CollisionShape2D = $CollisionShape2D
var in_range:= false

func _ready() -> void:
	collision_layer = 0
	collision_mask = 1
	
	body_shape_entered.connect(_on_body_shape_entered)
	body_shape_exited.connect(_on_body_shape_exited)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Entity && body != parent:
		in_range = true

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Entity  && body != parent:
		in_range = false
