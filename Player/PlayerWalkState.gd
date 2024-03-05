extends PlayerState

func enter():
	character.animation_player.play("walk")
	character.animation_player.speed_scale = 1

func physics_update(delta):
	character.upper_body.rotation = character.global_position.direction_to(character.get_global_mouse_position()).angle() + PI/2
	character.lower_body.rotation = character.dir.angle() + PI/2
	torso_rotation_clause()


func torso_rotation_clause() -> void:
	var left_rotation_check : float = character.lower_body.rotation + (3.0/4.0) * PI
	var right_rotation_check : float = character.lower_body.rotation - (3.0/4.0) * PI
	if right_rotation_check < left_rotation_check:
		if character.upper_body.rotation < right_rotation_check:
			character.upper_body.rotation += 2 * PI
		right_rotation_check += 2 * PI
	if character.upper_body.rotation < left_rotation_check || character.upper_body.rotation > right_rotation_check:
		return
	if character.upper_body.rotation - left_rotation_check > right_rotation_check - character.upper_body.rotation:
		character.upper_body.rotation = right_rotation_check
		return
	character.upper_body.rotation = left_rotation_check
