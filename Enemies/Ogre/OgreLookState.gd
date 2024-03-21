extends State


@onready var ogre_look_timer : Timer = $OgreLookTimer
@onready var _delta : float = 1.0/60.0


func enter():
	ogre_look_timer.start()
	character.emit_signal("change_rotation", _delta)


func exit():
	character.emit_signal("change_rotation", 0)


func _on_ogre_look_timer_timeout():
	emit_signal("state_change", "OgreWalk")
