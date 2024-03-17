class_name Ogre
extends CharacterBody2D


@onready var shape_cast_2d : ShapeCast2D = $Head/ShapeCast2D
@onready var ray_cast_2d : RayCast2D = $Head/RayCast2D
@onready var state_machine : StateMachine = $StateMachine


signal player_kill()
signal state_change(state_name : StringName)


var player : Player
var scene
var detection_started : bool = false


# TODO attack animation
# TODO walking animation
# TODO lookout animation
# TODO path progress + stop
# TODO state connections
# TODO player focused circle
# OPTIMIZE code placement


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	sight_detection()


func sight_detection():
	#if state_machine.current_state.name == "OgreAttack":
		#return
	if !shape_cast_2d.is_colliding():
		return
	ray_cast_2d.target_position = player.global_position - global_position
	if ray_cast_2d.is_colliding():
		return
	if detection_started:
		emit_signal("state_change", "OgreAttack")
	detection_started = true
