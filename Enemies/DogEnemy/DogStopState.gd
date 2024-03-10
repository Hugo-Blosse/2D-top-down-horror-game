extends State


@onready var stop_timer = $StopTimer
@onready var turn_check_left: ShapeCast2D = $"../../Rotatable/TurnCheckLeft"
@onready var turn_check_right : ShapeCast2D = $"../../Rotatable/TurnCheckRight"


signal change_walk_dir(walk_dir)
signal reverse_walk_dir(walk_dir_key)


const TCL : Dictionary = {
	0 : Vector2(0, -1),
	1 : Vector2(1, 0),
	2 : Vector2(0, 1),
	3 : Vector2(-1, 0)
}
const TCR : Dictionary = {
	0 : Vector2(0, 1),
	1 : Vector2(-1, 0),
	2 : Vector2(0, -1),
	3 : Vector2(1, 0)
}


var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func enter():
	character.dir = Vector2.ZERO
	character.animation_player.stop()
	stop_timer.start()


func exit():
	stop_timer.stop()
	stop_timer.wait_time = 1


func _on_stop_timer_timeout():
	emit_signal("state_change", "DogWalk")


func _on_dog_walk_check_new_dir(_walk_dir_key):
	stop_timer.wait_time = 0.1
	var new_directions : Array = []
	if !turn_check_left.is_colliding():
		new_directions.append(TCL[_walk_dir_key])
	if !turn_check_right.is_colliding():
		new_directions.append(TCR[_walk_dir_key])
	if !new_directions.is_empty():
		emit_signal("change_walk_dir", new_directions[rng.randi_range(0, new_directions.size() - 1)])
		return
	emit_signal("reverse_walk_dir", _walk_dir_key)
