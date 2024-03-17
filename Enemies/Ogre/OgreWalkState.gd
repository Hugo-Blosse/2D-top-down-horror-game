extends State


@onready var ogre_walk_timer : Timer = $OgreWalkTimer


const speed = 100


var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func enter():
	ogre_walk_timer.wait_time = rng.randi_range(4, 8)
	#ogre_walk_timer.start()


func exit():
	ogre_walk_timer.stop()


func _on_ogre_walk_timer_timeout():
	emit_signal("state_change", "OgreLook")
