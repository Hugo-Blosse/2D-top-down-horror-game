extends CharacterBody2D


@onready var navigation_agent_2d : NavigationAgent2D = $NavigationAgent2D


const speed = 50


var player : Player


func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()


func create_path() -> void:
	navigation_agent_2d.target_position = player.global_position

func _on_timer_timeout():
	create_path()
