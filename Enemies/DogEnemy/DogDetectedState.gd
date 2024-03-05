extends State


func enter():
	character.animation_player.play("run")
	character.run_speed = 100
	character.path_timer.start()


func exit():
	character.run_speed = 0
	character.path_timer.stop()


func physics_update(delta):
	character.dir = character.to_local(character.navigation_agent_2d.get_next_path_position()).normalized()
