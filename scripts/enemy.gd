extends Entity

func _ready() -> void:
	is_rscript = true
	repeat = true
	#rscript = ["move -fs=5"]
	rscript = ["dash", "circle -r"]
	
	is_cscript = true
	#"if(hit_wall):circle -r" , "if(!hit_wall):dash",
	cscript = ["if(in_range):attack"]
	
	
func die() -> void:
	queue_free()
