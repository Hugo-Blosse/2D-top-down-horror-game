extends StaticBody2D


@onready var sprite_2d = $Sprite2D


const max_speed : float = 400


var attack_ended : bool = false
var dir : Vector2 = Vector2.ZERO
var speed : float = 400


func _physics_process(delta):
	var collision = move_and_collide(speed * delta * dir)
	if attack_ended:
		return
	rotation = (dir.angle() - PI/2)
	if collision:
		speed = 0
