extends PlayerState

func enter():
	pass

func exit():
	pass

func physics_update(_delta):
	character.rotation = character.global_position.direction_to(character.get_global_mouse_position()).angle() + PI/2
