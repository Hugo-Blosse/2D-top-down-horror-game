extends PlayerState

func enter():
	character.animation_player.play("walk")
	character.animation_player.speed_scale = 1

func exit():
	pass

func physics_update(_delta):
	character.rotation = character.global_position.direction_to(character.get_global_mouse_position()).angle() + PI/2

