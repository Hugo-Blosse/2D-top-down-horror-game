extends Node2D


@onready var sprite_2d : Sprite2D = $Sprite2D


func _physics_process(delta):
	if scale >= Vector2(8, 8):
		queue_free()
	scale += Vector2(1, 1)/(2 * scale)
