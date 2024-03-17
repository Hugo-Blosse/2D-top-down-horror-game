extends State


func physics_update(delta):
	emit_signal("state_change", "OgreWalk")
	queue_free()
