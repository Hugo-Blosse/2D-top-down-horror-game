extends PlayerState

@export var run_speed = 150


func enter():
	character.restore_stamina = false
	%PlayerSoundArea.scale = Vector2(2, 2)
	if !character.is_flashlight_on:
		character.animation_player.speed_scale = 3
		character.animation_player.play("run")
	else:
		character.flashlight_animation.speed_scale = 3
		character.flashlight_animation.play("flashlight_run")
	character.run_speed = run_speed
	%StaminaRestoreTimer.stop()

func exit():
	%PlayerSoundArea.scale = Vector2(1, 1)
	%StaminaRestoreTimer.start()
	character.animation_player.stop()
	character.flashlight_animation.stop()
	character.run_speed = 0

func physics_update(_delta):
	character.stamina_bar.value -= 1
	character.upper_body.rotation = character.dir.angle() + PI/2
	character.lower_body.rotation = character.upper_body.rotation
