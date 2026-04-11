extends Entity

func _ready() -> void:
	is_rscript = true
	#rscript = ["move -fs=4", "turn -rs=.5"]
	rscript = ["dash -f"]
	is_cscript = true
	cscript = ["if(in_range):retreat"]
	
	
func die() -> void:
	queue_free()
