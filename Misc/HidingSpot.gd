extends Node2D


@onready var player : Player
@onready var hide_area : Area2D = $HideArea


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _input(event):
	if hide_area.overlaps_body(player) && Input.is_action_just_pressed("interact"):
		player.global_position = self.global_position
		player.hide_player()
