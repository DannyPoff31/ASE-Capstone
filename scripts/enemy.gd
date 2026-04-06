extends Entity

func _ready() -> void:
	is_script = true
	rscript = "move -fs=4;turn -rs=.5;"
	
func die() -> void:
	queue_free()
