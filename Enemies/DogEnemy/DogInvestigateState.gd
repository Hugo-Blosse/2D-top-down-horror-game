extends State


func enter():
	character.animation_player.play("run")
	character.run_speed = 100


func exit():
	character.run_speed = 0


func physics_update(delta):
	character.dir = character.to_local(character.navigation_agent_2d.get_next_path_position()).normalized()
	if character.global_position.distance_to(character.navigation_agent_2d.get_final_position()) <= 3 || character.player.is_hidden:
		_on_navigation_agent_2d_navigation_finished()


func _on_navigation_agent_2d_navigation_finished():
	emit_signal("state_change", "DogWalk")
