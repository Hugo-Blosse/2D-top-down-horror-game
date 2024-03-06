extends PlayerState

func enter():
	%PlayerSoundCollision.disabled = true

func exit():
	%PlayerSoundCollision.disabled = false

func physics_update(_delta):
	character.upper_body.rotation = character.global_position.direction_to(character.get_global_mouse_position()).angle() + PI/2
	character.lower_body.rotation = character.upper_body.rotation
