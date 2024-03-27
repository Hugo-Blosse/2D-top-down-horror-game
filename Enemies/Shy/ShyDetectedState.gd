extends State


@onready var light_detection_timer : Timer = $LightDetectionTimer


func enter():
	character.speed = get_character_speed()
	character.path_timer.start()


func _physics_process(delta):
	character.dir = character.to_local(character.shy_enemy_navigation_agent.get_next_path_position()).normalized()
	light_check()


func light_check() -> void:
	if !light_detection_timer.is_stopped():
		return
	if character.light_detection.get_overlapping_areas():
		light_detection_timer.start()


func get_character_speed() -> int:
	if character.target == character.player:
		return character.running_speed
	return character.walking_speed


func _on_light_detection_timer_timeout():
	emit_signal("state_change", "ShyIdle")
