class_name Fist
extends Weapon

func _ready() -> void:
	pass

func attack(params: Array) -> void:
	if(len(params) > 1):
		var options = params[1].split("")
		var paramIndex = 2
		if(options[0] == "-"):
			for op in options:
				pass
	else:
		print("children: ", get_children(true))
		sprite.visible = true
