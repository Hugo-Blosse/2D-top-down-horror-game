extends CharacterBody2D


@onready var navigation_agent_2d : NavigationAgent2D = $NavigationAgent2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var path_timer = $PathTimer
@onready var animation_player = $AnimationPlayer


signal state_change(state_name : StringName)


const walk_speed : float = 50


var run_speed : float = 0
var player : Player
var dir : Vector2


func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	sprite_2d.rotation = dir.angle() - PI/2
	velocity = dir * (walk_speed + run_speed)
	move_and_slide()


func create_path() -> void:
	navigation_agent_2d.target_position = player.global_position


func _on_path_timer_timeout():
	create_path()


func _on_detection_body_entered(body):
	if body is Player:
		emit_signal("state_change", "DogDetected")


func _on_detection_body_exited(body):
	if body is Player:
		print("ex")
		emit_signal("state_change", "DogWalk")
