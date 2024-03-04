extends State


func _physics_process(delta):
	emit_signal("state_change", "DogWalk")
	queue_free()
