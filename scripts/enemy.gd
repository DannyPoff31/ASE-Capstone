extends Entity

signal died

@export var ready_rscript: Array[String]
@export var ready_repeat: bool
@export var ready_cscript: Array[String]

func _ready() -> void:
	if ready_rscript: 
		is_rscript = true
		repeat = true
		rscript = ready_rscript
	if ready_cscript:
		is_cscript = true
		cscript = ready_cscript
	
	#rscript = ["move -fs=5"]
	#rscript = ["dash", "circle -r"]
	
	#is_cscript = true
	#"if(hit_wall):circle -r" , "if(!hit_wall):dash",
	#cscript = ["if(in_range):attack"]
	
	
func die() -> void:
	died.emit()
	queue_free()
