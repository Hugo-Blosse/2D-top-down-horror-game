extends State


func _physics_process(delta):
	emit_signal("state_change", "ShyIdle")
	queue_free()
