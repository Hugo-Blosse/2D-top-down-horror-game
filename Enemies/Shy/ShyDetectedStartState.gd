extends State


@onready var timer : Timer = $Timer


func enter():
	for light_detected in character.light_detection.get_overlapping_areas():
		if light_detected == character.player.flashlight_area:
			character.target = character.player
			break
		character.target = character.breaker
	timer.start()


func _physics_process(delta):
	pass


func _on_timer_timeout():
	emit_signal("state_change", "ShyDetected")
