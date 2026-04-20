extends Entity

func _ready() -> void:
	is_cscript = true
	cscript = ["if(in_range):retreat"]
	
	
func die() -> void:
	queue_free()
