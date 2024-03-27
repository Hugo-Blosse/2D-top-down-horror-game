extends State


@onready var timer : Timer = $Timer


func enter():
	character.target = character.player
	timer.start()


func _physics_process(delta):
	pass
	


func _on_timer_timeout():
	emit_signal("state_change", "ShyDetected")
