extends Node
class_name RScript

var script_name : String
var contents : String


func _init(s_name, cont):
	script_name = s_name
	contents = cont

func get_script_name() -> String:
	return script_name

func get_content() -> String:
	return contents
