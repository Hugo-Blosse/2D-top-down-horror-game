extends Node2D


@onready var attack_stop_timer : Timer = $AttackStopTimer
@onready var attack_segments : Node2D = $AttackSegments


var attack_end = preload("res://Enemies/Ogre/OgreAttack/ogre_attack_end.tscn")
var attack_middle = preload("res://Enemies/Ogre/OgreAttack/ogre_attack_middle.tscn")
var attack_ended : bool = false
var current_attack_segment : StaticBody2D
var dir : Vector2 = Vector2.ZERO


signal attack_finished()


# OPTIMIZE attack


func _ready():
	add_segment()


func _physics_process(delta):
	if !attack_ended && global_position.distance_to(current_attack_segment.global_position) >= 16:
		add_segment()
	if attack_ended:
		if !attack_segments.get_children():
			emit_signal("attack_finished")
			queue_free()
		for child : StaticBody2D in attack_segments.get_children():
			if global_position.distance_to(child.global_position) <= 16:
				child.queue_free()


func add_segment():
	attack_stop_timer.start()
	if current_attack_segment == null: 
		current_attack_segment = attack_end.instantiate()
	else:
		current_attack_segment = attack_middle.instantiate()
	current_attack_segment.dir = dir
	attack_segments.add_child(current_attack_segment)


func _on_attack_stop_timer_timeout():
	attack_ended = true
	for child : StaticBody2D in attack_segments.get_children():
		child.dir = -child.dir
		child.attack_ended = true
		child.speed = child.max_speed
		child.set_collision_layer_value(5, false)
