extends Node2D


@onready var player : Player
@onready var hide_area : Area2D = $HideArea
@onready var collision_shape_2d : CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var animation_player : AnimationPlayer = $HidingSpotAnimationPlayer


func _ready():
	player = get_tree().get_first_node_in_group("player")
	animation_player.speed_scale = 2


func _input(event):
	if !hide_area.overlaps_body(player) || !Input.is_action_just_pressed("interact") || !player.hide_timer.is_stopped():
		return
	if !player.is_hidden:
		player.global_position = $HideArea/CollisionShape2D.global_position
		animation_player.play("door_close")
		player.hide_player()
	else:
		animation_player.play("door_open")
