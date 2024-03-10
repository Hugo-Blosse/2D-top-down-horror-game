extends PlayerState


func enter():
	character.set_collision_layer_value(4, false)
	character.animation_player.stop()
	character.dir = Vector2.ZERO
	if character.is_flashlight_on:
		character.flashlight_animation.play("flashlight_end")
	%PlayerSoundCollision.disabled = true
	$HideTimer.start()


func exit():
	character.set_collision_layer_value(4, true)


func physics_update(delta):
	character.upper_body.rotation = character.global_position.direction_to(character.get_global_mouse_position()).angle() + PI/2
	character.lower_body.rotation = character.upper_body.rotation


func _input(event):
	if character.is_hidden && Input.is_action_just_pressed("interact"):
		$HideTimer.start()
		emit_signal("state_change", "PlayerIdle")
