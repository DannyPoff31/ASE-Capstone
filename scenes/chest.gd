extends ItemContainer

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	super()
	sprite.play("default")
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit_box: HitBox) -> void:
	open()


func open() -> void:
	sprite.play("open")
