extends PlayerState

@export var run_speed = 150


func enter():
	character.restore_stamina = false
	character.animation_player.play("walk")
	character.animation_player.speed_scale = 3
	character.run_speed = run_speed
	%StaminaRestoreTimer.stop()

func exit():
	%StaminaRestoreTimer.start()
	character.run_speed = 0

func physics_update(_delta):
	character.stamina_bar.value -= 1
	character.rotation = character.dir.angle() + PI/2
