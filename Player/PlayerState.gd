class_name PlayerState
extends State


func _input(event):
	if Input.is_action_pressed("focus"):
		if %FocusTimer.is_stopped():
			%FocusTimer.start()
		return
	if state_machine.current_state.name == "PlayerHide":
		return
	character.dir.x = Input.get_axis("left", "right")
	character.dir.y = Input.get_axis("up", "down")
	if character.dir != Vector2.ZERO:
		if Input.is_action_pressed("run") && character.stamina_bar.value > 0:
			emit_signal("state_change", "PlayerRun")
			return
		else:
			emit_signal("state_change", "PlayerWalk")
	if Input.is_action_just_pressed("flashlight"):
		if !character.is_flashlight_on:
			character.flashlight_animation.play("flashlight_start")
		else:
			character.flashlight_animation.play("flashlight_end")
	if Input.is_action_just_released("focus"):
		character.focused = false
		%FocusTimer.stop()
