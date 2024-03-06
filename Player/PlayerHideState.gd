extends PlayerState


func enter():
	character.set_collision_layer_value(4, false)
	%PlayerSoundCollision.disabled = true
	$Timer.start()


func exit():
	character.set_collision_layer_value(4, true)


func _input(event):
	if !character.is_hidden:
		return
	if Input.is_action_just_pressed("interact"):
		character.is_hidden = false
		emit_signal("state_change", "PlayerIdle")


func _on_timer_timeout():
	character.is_hidden = true
