class_name PlayerState
extends State

func _input(event):
	character.dir.x = Input.get_axis("left", "right")
	character.dir.y = Input.get_axis("up", "down")
	if character.dir != Vector2.ZERO:
		if Input.is_action_pressed("run") && character.stamina_bar.value > 0:
			emit_signal("state_change", "PlayerRun")
		else:
			emit_signal("state_change", "PlayerWalk")
	if Input.is_action_just_pressed("flashlight") && state_machine.current_state.name != "PlayerRun":
		if !character.is_flashlight_on:
			character.flashlight_animation.play("flashlight_start")
		else:
			character.flashlight_animation.play("flashlight_end")
