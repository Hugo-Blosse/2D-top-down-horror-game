extends State


@onready var walk_timer = $"../DogWalk/WalkTimer"


signal check_new_dir(_walk_dir)


const walk_dir : Dictionary = {
	0 : Vector2(1, 0),
	1 : Vector2(0, 1),
	2 : Vector2(-1, 0),
	3 : Vector2(0, -1)
}


var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var changed_walk_dir : Vector2
var first_frame_checked : bool
var walk_dir_key : int


func enter():
	for body in %Detection.get_overlapping_bodies():
		if body is Player:
			emit_signal("state_change", "DogDetected") 
	character.animation_player.play("walk")
	walk_timer.wait_time = rng.randf_range(2, 10)
	walk_timer.start()
	first_frame_checked = false
	if changed_walk_dir != Vector2.ZERO:
		character.dir = changed_walk_dir
		changed_walk_dir = Vector2.ZERO
		return
	walk_dir_key = rng.randi_range(0,3)
	character.dir = walk_dir[walk_dir_key]


func exit():
	walk_timer.stop()


func physics_update(delta):
	if character.wall_check.is_colliding() && first_frame_checked:
		emit_signal("check_new_dir", walk_dir_key)
		emit_signal("state_change", "DogStop")
	first_frame_checked = true


func _on_walk_timer_timeout() -> void:
	emit_signal("state_change", "DogStop")


func _on_dog_change_walk_dir(walk_dir_ : Vector2) -> void:
	changed_walk_dir = walk_dir_
	walk_dir_key = walk_dir.find_key(walk_dir_)


func _on_dog_reverse_walk_dir(_walk_dir_key) -> void:
	changed_walk_dir = -walk_dir[_walk_dir_key]
