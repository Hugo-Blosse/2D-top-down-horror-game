extends CharacterBody2D


@onready var light_detection : Area2D = $LightDetection
@onready var shy_enemy_navigation_agent : NavigationAgent2D = $ShyEnemyNavigationAgent
@onready var path_timer : Timer = $PathTimer
@onready var state_machine : StateMachine = $StateMachine


signal player_kill()
signal state_change(state_name : StringName)


const running_speed = 300
const walking_speed = 50

var player : Player
var scene
var detection_started : bool = false
var target : Node2D
var speed : float = 100
var dir : Vector2 = Vector2.ZERO


func _physics_process(delta):
	player = get_tree().get_first_node_in_group("player")
	if state_machine.current_state.name != "ShyDetected" && light_detection.get_overlapping_areas():
		emit_signal("state_change", "ShyDetectedStart")
	velocity = speed * dir
	move_and_slide()


func create_path() -> void:
	if target:
		shy_enemy_navigation_agent.target_position = target.global_position


func _on_path_timer_timeout():
	create_path()
