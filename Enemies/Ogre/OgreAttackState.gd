extends State


var ogre_attack = preload("res://Enemies/Ogre/OgreAttack/ogre_attack.tscn")


func enter():
	var o = ogre_attack.instantiate()
	o.global_position = character.global_position
	o.dir = character.global_position.direction_to(character.player.global_position)
	add_child(o)


func exit():
	pass


func physics_update(_delta):
	pass

