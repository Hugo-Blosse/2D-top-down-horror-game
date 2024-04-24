extends State


@onready var timer : Timer = $Timer


func enter():
	find_detected_lights()
	timer.start()


func _physics_process(delta):
	pass


func find_detected_lights():
	for light_detected in character.light_detection.get_overlapping_areas():
		if light_detected == character.player.flashlight_area:
			character.shy_enemy_ray.target_position = character.global_position.direction_to(character.player.flashlight.global_position)*character.global_position.distance_to(character.player.flashlight.global_position)
			character.target = character.player
			break
		character.target = character.breaker


func _on_timer_timeout():
	emit_signal("state_change", "ShyDetected")
