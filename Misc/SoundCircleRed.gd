extends Node2D


@onready var sprite_2d : Sprite2D = $Sprite2D


var scale_multiplier : Vector2 = Vector2(1, 1)


func _physics_process(delta):
	if scale >= Vector2(8, 8) * scale_multiplier:
		queue_free()
	scale += (Vector2(1, 1)/(2 * scale)) * scale_multiplier
