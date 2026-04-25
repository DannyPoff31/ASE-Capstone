extends ItemContainer

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	super()
	sprite.play("default")
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit_box: HitBox) -> void:
	open()
	get_tree().change_scene_to_file("res://scenes/win.tscn")


func open() -> void:
	sprite.play("open")
