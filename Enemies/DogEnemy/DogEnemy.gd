extends CharacterBody2D


var scr = preload("res://Misc/sound_circle_red.tscn")


@onready var navigation_agent_2d : NavigationAgent2D = $NavigationAgent2D
@onready var path_timer : Timer = $PathTimer
@onready var rotatable : Node2D = $Rotatable
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var wall_check : ShapeCast2D = $Rotatable/WallCheck
@onready var sound_circle_timer : Timer = $SoundCircleTimer


signal state_change(state_name : StringName)


const walk_speed : float = 50


var run_speed : float = 0
var player : Player
var dir : Vector2
var last_dir : Vector2
var scene : Node2D


# TODO attack


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if dir != Vector2.ZERO:
		rotatable.rotation = dir.angle() - PI/2
		last_dir = dir
	else:
		rotatable.rotation = last_dir.angle() - PI/2
	if player.focused && sound_circle_timer.is_stopped():
		var scr_inst = scr.instantiate()
		scr_inst.global_position = self.global_position
		scene.add_child(scr_inst)
		sound_circle_timer.start()
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
		if !%Detection.overlaps_area(player.player_sound_area) && body is Player:
			emit_signal("state_change", "DogInvestigate")


func _on_detection_area_entered(area):
	if area.name == "PlayerSoundArea":
		emit_signal("state_change", "DogDetected")


func _on_detection_area_exited(area):
	if !%Detection.overlaps_body(player) && area.name == "PlayerSoundArea":
			emit_signal("state_change", "DogInvestigate")


func create_sound_circle() -> void:
	pass
