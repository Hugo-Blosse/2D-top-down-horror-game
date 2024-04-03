extends State


@onready var light_detection_timer : Timer = $LightDetectionTimer


func enter():
	character.speed = get_character_speed()
	character.path_timer.start()


func _physics_process(delta):
	character.dir = character.to_local(character.shy_enemy_navigation_agent.get_next_path_position()).normalized()
	light_check()


func light_check() -> void:
	if !character.target:
		return
	if !light_detection_timer.is_stopped():
		return
	if character.light_detection.get_overlapping_areas() && character.target == character.player:
		light_detection_timer.start()
		return
	check_destination()


func check_destination():
	if character.global_position.distance_to(character.target.global_position) >= 4:
		return
	if character.target == character.breaker:
		character.global_position = character.target.global_position
		character.breaker._breaker_used()
		character.target = character.starting_position
		return
	if character.target == character.starting_position:
		character.global_position = character.target.global_position
		character.target = null
		emit_signal("state_change", "ShyIdle")


func get_character_speed() -> int:
	if character.target == character.player:
		return character.running_speed
	return character.walking_speed


func _on_light_detection_timer_timeout():
	emit_signal("state_change", "ShyIdle")
