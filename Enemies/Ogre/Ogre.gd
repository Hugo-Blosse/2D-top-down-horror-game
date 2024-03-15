extends CharacterBody2D


@onready var shape_cast_2d : ShapeCast2D = $ShapeCast2D
@onready var ray_cast_2d : RayCast2D = $RayCast2D


signal player_kill()


var player : Player
var scene : Node2D


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if !shape_cast_2d.is_colliding():
		ray_cast_2d.enabled = false
		return
	var line_of_sight : Vector2 = global_position.direction_to(player.global_position) * global_position.distance_to(player.global_position)
	ray_cast_2d.target_position = line_of_sight
	print(ray_cast_2d.target_position)
	ray_cast_2d.enabled = true
	if ray_cast_2d.is_colliding():
		print("XD")
		return
	print("doesnt collide")
			
