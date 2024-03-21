class_name Ogre
extends CharacterBody2D


@onready var shape_cast_2d : ShapeCast2D = $Head/ShapeCast2D
@onready var ray_cast_2d : RayCast2D = $Head/RayCast2D
@onready var state_machine : StateMachine = $StateMachine
@onready var sound_circle_timer : Timer = $SoundCircleTimer


signal player_kill()
signal state_change(state_name : StringName)
signal change_path_speed(new_speed : float)
signal change_rotation(new_rotation : float)

var scr = preload("res://Misc/sound_circle_red.tscn")
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
	create_sound_circle()


func sight_detection() -> void:
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


func create_sound_circle() -> void:
	if player.focused && sound_circle_timer.is_stopped():
		var scr_inst = scr.instantiate()
		scr_inst.global_position = self.global_position
		scr_inst.scale_multiplier = Vector2(3, 3)
		scene.add_child(scr_inst)
		sound_circle_timer.start()
