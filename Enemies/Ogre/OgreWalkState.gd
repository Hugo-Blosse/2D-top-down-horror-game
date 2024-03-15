extends State


func _physics_process(delta):
	print("XD")
	emit_signal("state_change", "OgreWalk")
